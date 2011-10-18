module RCat
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)

      @display        = RCat::Display.new(@params)
    end

    def run
      if @files.empty?
        @display.render(STDIN)
      else
        @files.each do |filename|
          File.open(filename) { |f| @display.render(f) }
        end 
      end
    end

    def parse_options(argv)
      params = {}
      files  = OptionParser.new do |parser|
        parser.on("-n") { params[:line_numbering_style] ||= :all_lines         }
        parser.on("-b") { params[:line_numbering_style]   = :significant_lines }
        parser.on("-s") { params[:squeeze_extra_newlines] = true               }
      end.parse(argv)

      [params, files]
    end
  end
end
