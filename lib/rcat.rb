module RCat
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)
      @display       = Display.new(@params)
    end

    def run
      @files.each { |f| @display.render_file(f) }
    end

    def parse_options(argv)
      params = {}
      files  = OptionParser.new do |parser|
        parser.on("-n") { params[:line_numbering] = :all_lines         }
        parser.on("-b") { params[:line_numbering] = :significant_lines }
        parser.on("-s") { params[:squeeze]        = true               }
      end.parse(argv)

      [params, files]
    end
  end

  class Display
    def initialize(params)
      @line_numbering = params[:line_numbering]
      @squeeze        = params[:squeeze]
    end

    def render_file(filename)
      @current_line = 1
      File.foreach(filename) { |line| render_line(line) }
    end

    def render_line(line)
      case @line_numbering
      when :all_lines
        print "#{@current_line.to_s.rjust(6)}  #{line}" 
        @current_line += 1
      when :significant_lines
        if line.chomp.empty?
          print line
        else
          print "#{@current_line.to_s.rjust(6)}  #{line}" 
          @current_line += 1
        end
      else
        print line
        @current_line += 1
      end
    end
  end
end
