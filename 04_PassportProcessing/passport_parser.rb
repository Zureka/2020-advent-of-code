class PassportParser
  class << self
    def passport_structure_valid?(info_str)
      info_str.include?("byr") &&
        info_str.include?("iyr") &&
        info_str.include?("eyr") &&
        info_str.include?("hgt") &&
        info_str.include?("hcl") &&
        info_str.include?("ecl") &&
        info_str.include?("pid")
    end

    def passport_info_valid?(info_str)
      info = info_str.split(" ")
      birth_year_valid?(info) &&
        issue_year_valid?(info) &&
        expiration_year_valid?(info) &&
        height_valid?(info) &&
        hair_color_valid?(info) &&
        eye_color_valid?(info) &&
        passport_id_valid?(info)
    end

    private

    def get_key_value(key, info)
      value_str = info.select { |i| i.include? key }[0]
      value_str.split(":")[1]
    end

    def year_valid?(info, field, min, max)
      year = get_key_value(field, info).to_i
      year >= min && year <= max
    end

    def birth_year_valid?(info)
      year_valid?(info, "byr", 1920, 2002)
    end

    def issue_year_valid?(info)
      year_valid?(info, "iyr", 2010, 2020)
    end

    def expiration_year_valid?(info)
      year_valid?(info, "eyr", 2020, 2030)
    end

    def height_valid?(info)
      value = get_key_value("hgt", info)

      if value.include? "cm"
        height_cm = value.gsub("cm", "").to_i
        height_cm >= 150 && height_cm <= 193
      elsif value.include? "in"
        height_in = value.gsub("in", "").to_i
        height_in >= 59 && height_in <= 76
      else
        false
      end
    end

    def hair_color_valid?(info)
      value = get_key_value("hcl", info)
      /^#[a-f0-9]{6}$/.match?(value)
    end

    def eye_color_valid?(info)
      value = get_key_value("ecl", info)

      case value
      when "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
        true
      else
        false
      end
    end

    def passport_id_valid?(info)
      value = get_key_value("pid", info)
      /^[0-9]{9}$/.match?(value)
    end
  end
end
