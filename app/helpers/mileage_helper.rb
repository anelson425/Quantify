require 'action_view'

module MileageHelper

  def create_table(activities)
    table_rows = []

    activities.each do |activity|
      table_rows << content_tag(:tr) do
        content_tag(:td, activity.date)
        content_tag(:td, activity.distance_mi)
        content_tag(:td, activity.time_min)
        content_tag(:td, activity.total_distance_mi)
      end
    end
    table_rows
  end
end
