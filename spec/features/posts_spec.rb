describe "the signin process", js: true do
  login_success

  it "create new post" do
    admin_sign_in
    visit "#{root_url}/admin/post_type/2/posts/new"
    within("#form-post") do
      fill_in 'post_title', :with => 'Test Title'
      page.execute_script('$("#form-post .tinymce_textarea").tinymce().setContent("Pants are pretty sweet.")')
      fill_in 'post_summary', :with => 'test summary'
      fill_in 'post_keywords', :with => 'test keywords'
      fill_in 'tags', :with => 'owen,dota'
      check("Uncategorized")
    end
    # wait(60)
    click_button 'Create'
    expect(page).to have_css('.alert-success')
  end

  it "create edit post" do
    admin_sign_in
    visit "#{root_url}/admin/post_type/2/posts/#{get_content_attr("post", "id", "last")}/edit"
    within("#form-post") do
      fill_in 'post_title', :with => 'Test Title changed'
      page.execute_script('$("#form-post .tinymce_textarea").tinymce().setContent("Pants are pretty sweet. chaged")')
      fill_in 'post_summary', :with => 'test summary changed'
      fill_in 'post_keywords', :with => 'test keywords changed'
    end
    click_button 'Update'
    expect(page).to have_css('.alert-success')
  end
end