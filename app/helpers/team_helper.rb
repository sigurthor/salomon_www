module TeamHelper
  def set_column_number(category_name)
    {:class => (category_name != 'Nationals' ? 'large-block-grid-4' : 'large-block-grid-6')}
  end
  def slider_viewport
    @wrapper_width = ((@team_member.category.team_members.count * 160) - 20)
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

  def is_current_category(category_name)
    @id = category_name.downcase + '-category'
    if @team_member.category.name == category_name
      {:id => @id, :class => 'current-category'}
    else
      {:id => @id, :class => ''}
    end
  end

  def get_profile_image(thumb_image)
    !thumb_image.blank? ? thumb_image.identifier : 'v1378218989/salomon-profile-missing_nawqev.jpg'
  end

  def get_profile_video_bg(video_bg)
    unless video_bg.blank?
      {:style => 'background-image: url("' + cl_image_path(@team_member.main_image, :width => 1200, :height => 663, :crop => 'fill') + '");'}
    else
      {:style => 'background-image: url("/assets/fixme-missing-profile-video.jpg");'}
    end
  end

  def is_current_team_nav_category(category)
    if category.name == @team_member.category.name
      {:class => 'current-team-nav-category', :id => 'nav-' + category.name.downcase}
    else
      {:id => 'nav-' + category.name.downcase}
    end
  end

  def gear_heading
    unless @team_member.products.empty?
      render :text => 'Gear Used'
    end
  end

end
