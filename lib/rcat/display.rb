module RCat
  class Display
    def initialize(params)
      @line_numbering_style   = params[:line_numbering_style]
      @squeeze_extra_newlines = params[:squeeze_extra_newlines]
    end

    def render(data)
      @line_number = 1

      lines = data.lines
      loop { render_line(lines) }
    end

    private

    attr_reader :line_numbering_style, :squeeze_extra_newlines, :line_number

    def render_line(lines)
      current_line = lines.next 
      current_line_is_blank = current_line.chomp.empty?

      case line_numbering_style
      when :all_lines
        print_labeled_line(current_line)
        increment_line_number  
      when :significant_lines
        if current_line_is_blank
          print_unlabeled_line(current_line)
        else
          print_labeled_line(current_line)
          increment_line_number
        end
      else
        print_unlabeled_line(current_line)
        increment_line_number
      end

      if squeeze_extra_newlines && current_line_is_blank
         lines.next while lines.peek.chomp.empty?
      end
    end

    def print_labeled_line(line)
      print "#{line_number.to_s.rjust(6)}\t#{line}" 
    end

    def print_unlabeled_line(line)
      print line
    end

    def increment_line_number
      @line_number += 1
    end
  end
end
