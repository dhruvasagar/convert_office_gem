class ConvertOfficeFormat
  JAR_PATH= File.expand_path(File.join(File.dirname(__FILE__),"..", "java", "convert_office.jar"))
  TEXT_FORMAT = %w(pdf odt sxw rtf  doc txt html wiki docx)
  XL_FORMAT = %w(pdf ods sxc xls csv tsv html xlsx)
  PT_FORMAT = %w(pdf swf odp sxi ppt html pptx)
  ODG_FORMAT = %w(svg swf)
  VALID_FORMAT=	{
          "odt"=>TEXT_FORMAT,
          "sxw"=>TEXT_FORMAT,
          "rtf"=>TEXT_FORMAT,
          "doc"=>TEXT_FORMAT,
          "wpd"=>TEXT_FORMAT,
          "txt"=>TEXT_FORMAT,
          "html"=>TEXT_FORMAT,
          "htm"=>TEXT_FORMAT,
          "ods"=>XL_FORMAT,
          "sxc"=>XL_FORMAT,
          "xls"=>XL_FORMAT,
          "csv"=>XL_FORMAT,
          "tsv"=>XL_FORMAT,
          "odp"=>PT_FORMAT,
          "sxi"=>PT_FORMAT,
          "ppt"=>PT_FORMAT,
          "pptx"=>PT_FORMAT,
          "odg"=>ODG_FORMAT
  }

  def self.configure(config)
    @config = YAML.load_file(config)
  end

  def self.convert(input_file, output_file)
    java_bin = @config['java_bin']
    port_no = @config['soffice_port']

    input_extension_name = File.extname(input_file).split(".").last
    format = File.extname(output_file).split('.').last

    if check_valid_conversion?(input_extension_name, format)
      command = "#{java_bin} -Xmx512m -Djava.awt.headless=true -cp #{JAR_PATH} com.artofsolving.jodconverter.cli.ConvertDocument -p #{port_no} #{input_file} #{output_file}"
      system(command)
    end
  end

  def self.display_valid_formats(file_name="")
    if !file_name.empty?
      input_extension_name = file_name.split(".").last
      if VALID_FORMAT[input_extension_name].nil?
        puts "Not A Proper Format"
        VALID_FORMAT.each do |k,v|
          puts "#{k} => #{v.join(",")}"
        end
      else
        puts VALID_FORMAT[input_extension_name].join(",")
      end
    else
      VALID_FORMAT.each do |k,v|
          puts "#{k} => #{v.join(",")}"
      end
    end
  end  

  def self.check_valid_conversion?(input_ext,format)
    if VALID_FORMAT[input_ext].nil?
      puts "Please provide proper input file"
      puts "Input file type #{VALID_FORMAT.keys.join(",")}"
      return false
    elsif	!VALID_FORMAT[input_ext].include?(format)
      puts "Please provide proper output format/output file"
      puts "Format/Output file must be #{VALID_FORMAT[input_ext].join(",")}"
      return false
    else
      return true
    end
  end
end
