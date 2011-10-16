module RCat
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
