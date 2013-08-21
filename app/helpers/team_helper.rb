module TeamHelper
  def set_column_number(category_name)
    {:class => (category_name != 'Nationals' ? 'large-block-grid-4' : 'large-block-grid-2')}
  end
  def slider_viewport
    @wrapper_width = ((@total_riders * 160) - 20)
    @margin_left = (-(@wrapper_width / 2).abs)
    {:style => 'width: ' + @wrapper_width.to_s + 'px; margin-left: ' + @margin_left.to_s + 'px'}
  end
  def get_permalink(team_member)
    @permalink = team_member_path(:team_member => team_member.slug).to_s
    @permalink
  end

  def member_detail_is_empty(team_member_detail)
    team_member_detail.blank?
  end

end
