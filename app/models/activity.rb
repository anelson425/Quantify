class Activity
  include ActiveModel::Model

  attr_accessor :date, :distance_mi, :time_min, :total_distance_mi, :milestone

  # outputs as JSON so we can pass it through to the email controller as a parameter
  def to_s()
    hash = {}
    self.instance_variables.each do |var|
        hash[var] = self.instance_variable_get var
    end
    hash.to_json
  end
end
