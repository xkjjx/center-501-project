# frozen_string_literal: true

# spec/support/attributes.rb
module TestAttributes
  def valid_attributes
    {
      email: 'testuser@example.com',
      full_name: 'Test User',
      uid: '1234567890',
      avatar_url: 'http://example.com/avatar.jpg',
      user_type: 'user',
      phone_number: '1234567890',
      class_year: 2020,
      dietary_restriction: 'Vegan',
      linkedin_url: 'https://linkedin.com/in/testuser'
    }
  end

  def valid_officer_attributes
    {
      email: 'testuser-admin@example.com',
      full_name: 'Test User',
      uid: '1234567890',
      avatar_url: 'http://example.com/avatar.jpg',
      user_type: 'officer',
      phone_number: '1234567890',
      class_year: 2020,
      dietary_restriction: 'Vegan',
      linkedin_url: 'https://linkedin.com/in/testuser'
    }
  end

  def valid_admin_attributes
    {
      email: 'testuser-admin@example.com',
      full_name: 'Test User',
      uid: '1234567890',
      avatar_url: 'http://example.com/avatar.jpg',
      user_type: 'admin',
      phone_number: '1234567890',
      class_year: 2020,
      linkedin_url: 'https://linkedin.com/in/testuser'
    }
  end

  def invalid_attributes
    {
      email: nil,
      full_name: '',
      uid: nil,
      avatar_url: 'not_a_valid_url',
      user_type: 'invalid_type',
      linkedin_url: 'https://linkedin.com/in/testuser'
    }
  end

  def valid_project_attributes
    {
      projectName: 'Delta Research',
      projectDesc: 'Initiating new research projects under the Delta initiative.',
      projectStartDate: Date.new(2024, 12, 5),
      locationID: 4,
      isProjectActive: true,
      markdownBody: '# Delta Research\nResearch objectives and timelines.'
    }
  end

  def valid_project_attributes2
    {
      projectName: 'Epsilon Closure',
      projectDesc: 'Formal closure of the Epsilon facility.',
      projectStartDate: Date.new(2025, 3, 30),
      locationID: 5,
      isProjectActive: false,
      markdownBody: nil
    }
  end

  def valid_photo_attributes1
    {
      description: 'Sample photo',
      displayed_in_home_gallery: true,
      url: 'http://example.com/photo.jpg',
      project_id: Project.create(valid_project_attributes).id
    }
  end

  def valid_photo_attributes2
    {
      description: 'Another sample photo',
      displayed_in_home_gallery: false,
      url: 'http://example.com/photo2.jpg'
    }
  end

  def invalid_photo_attributes
    {
      description: '',
      displayed_in_home_gallery: nil,
      url: '',
      project_id: nil
    }
  end
end
