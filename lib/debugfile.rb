#
# debugfile - store temporary file for debugging, based on ruby/mri/lib/tempfile.rb
#
#

require 'delegate'
require 'tmpdir'
require 'securerandom'

#
# == Synopsis
#
#  require 'debugfile'
#
#  file = Debugfile.new('for_debug', 'foo.zip')
#  file.path #=> e.g.: "/tmp/for_debug/20140226/e34d7899-09cf-4b46-8ef4-4f751f9ae649-foo.zip"
#  file.write "hello!"
#  file.rewind
#  file.read  #=> "hello!"
#  file.close
#
#  file = Debugfile.open('for_debug', 'foo.zip') {|f| f.write "Ruby!" }
#  file.open
#  file.read #=> "Ruby!"
class Debugfile < DelegateClass(File)
  def initialize(outdirname, outfilename, tempdir=Dir.tmpdir, opts={})
    if block_given?
      warn "Debugfile.new doesn't call the given block."
    end

    mode = File::RDWR|File::CREAT|File::EXCL
    perm = 0600
    if opts
      mode |= opts.delete(:mode) || 0
      opts[:perm] = perm
      perm = nil
    else
      opts = perm
    end

    datedir = File.join(tempdir, outdirname, Time.now.strftime("%Y%m%d"))
    FileUtils.mkdir_p datedir if !FileTest.exist? datedir
    fulloutfilename = "#{SecureRandom.uuid}-#{outfilename}"
    @path = File.join(datedir, fulloutfilename)
    @debugfile = File.open(@path, mode, opts)
    @mode = mode & ~(File::CREAT|File::EXCL)
    perm or opts.freeze
    @opts = opts
    super @debugfile
  end

  def open
    @debugfile.close if @debugfile
    @debugfile = File.open(@path, @mode, @opts)
    __setobj__ @debugfile
  end

  def close
    File.unlink @debugfile if @debugfile.size == 0
    begin
      @debugfile.close
    ensure
      @debugfile = nil
    end
  end

  def inspect
    "#<#{self.class}:#{path}>"
  end

  class << self
    def open(*args)
      debugfile = new(*args)

      if block_given?
        begin
          yield debugfile
        ensure
          debugfile.close
        end
      else
        debugfile
      end
    end
  end
end
