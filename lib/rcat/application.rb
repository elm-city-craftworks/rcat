module RCat
  class Application
    def initialize(argv)
      @params, @files = parse_options(argv)
      @display        = RCat::Display.new(@params)
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
end
