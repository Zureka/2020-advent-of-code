class BagParser
  class << self
    def parse_bag_rule(rule)
      modified_rule = rule.delete(".")
        .gsub("bags", "")
        .gsub("bag", "")

      rule_parts = modified_rule.split("contain")

      contain_info = rule_parts[1].split(",").map { |info|
        split_info = info.split(" ")
        {
          num: split_info[0].to_i,
          color: "#{split_info[1]} #{split_info[2]}"
        }
      }

      if rule.include?("no other")
        contain_colors = []
      end

      {
        bag_color: rule_parts[0].strip,
        contain_colors: rule.include?("no other") ? [] : contain_info
      }
    end
  end
end
