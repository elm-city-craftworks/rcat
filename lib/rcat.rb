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
      @line_number = 1

      File.open(filename) do |f|
        lines = f.lines
        loop { render_line(lines) }
      end
    end

    def render_line(lines)
      line = lines.next

      current_line_empty = line.chomp.empty?

      case @line_numbering
      when :all_lines
        print "#{@line_number.to_s.rjust(6)}  #{line}" 
        @line_number += 1
      when :significant_lines
        if current_line_empty
          print line
        else
          print "#{@line_number.to_s.rjust(6)}  #{line}" 
          @line_number += 1
        end
      else
        print line
        @line_number += 1
      end

      if @squeeze && current_line_empty 
        loop do
          next_line = lines.peek

          if next_line.chomp.empty?
            lines.next
          else
            break
          end
        end
      end
    end
  end
end
