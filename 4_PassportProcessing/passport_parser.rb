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
      info_array = info_str.split(" ")
      birth_year_valid?(info_array) &&
        issue_year_valid?(info_array) &&
        expiration_year_valid?(info_array) &&
        height_valid?(info_array) &&
        hair_color_valid?(info_array) &&
        eye_color_valid?(info_array) &&
        passport_id_valid?(info_array)
    end

    private

    def year_valid?(info, field, min, max)
      year_str = info.select { |i| i.include? field }[0]
      year = year_str.split(":")[1].to_i
      year >= min && year <= max
    end

    def birth_year_valid?(info_array)
      year_valid?(info_array, "byr", 1920, 2002)
    end

    def issue_year_valid?(info_array)
      year_valid?(info_array, "iyr", 2010, 2020)
    end

    def expiration_year_valid?(info_array)
      year_valid?(info_array, "eyr", 2020, 2030)
    end

    def height_valid?(info_array)
      value_str = info_array.select { |i| i.include? "hgt" }[0]
      value = value_str.split(":")[1]

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

    def hair_color_valid?(info_array)
      value_str = info_array.select { |i| i.include? "hcl" }[0]
      value = value_str.split(":")[1]
      /^#[a-f0-9]{6}$/.match?(value)
    end

    def eye_color_valid?(info_array)
      value_str = info_array.select { |i| i.include? "ecl" }[0]
      value = value_str.split(":")[1]

      case value
      when "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
        true
      else
        false
      end
    end

    def passport_id_valid?(info_array)
      value_str = info_array.select { |i| i.include? "pid" }[0]
      value = value_str.split(":")[1]
      /^[0-9]{9}$/.match?(value)
    end
  end
end
