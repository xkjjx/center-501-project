# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/projects', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # adjust the attributes here as well.
  let(:location_info) do
    {
      id: 1,
      address: "12345",
      city: "College Station",
      state: "Texas",
      zip_code:"77840",
      country: "USA"
    }
  end
  include TestAttributes
  include RequestHelpers
  let(:valid_project_attributes) do
    {
      projectName: 'Test Project',
      projectDesc: 'This is a Test Description.',
      projectStartDate: Date.today,
      locationID: 1,
      isProjectActive: true
    }
  end

  let(:invalid_project_attributes) do
    {
      projectName: '',
      projectDesc: '',
      projectStartDate: nil,
      locationID: 0,
      isProjectActive: nil
    }
  end

  describe 'GET /index' do
    context 'when no one is logged in' do
      it 'renders a successful response' do
        Project.create! valid_project_attributes
        Location.create! location_info
        get projects_url
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /show' do
    context 'when no one is logged in' do
      it 'renders a successful response' do
        project = Project.create! valid_project_attributes
        get project_url(project)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /new' do
    context 'when officer is logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }
      
      before do
        sign_in officer
      end

      it 'renders a successful response' do
        get new_project_url
        expect(response).to be_successful
      end
    end

    context 'when regular user is logged in' do
      let(:user) { User.create!(valid_attributes) }

      before do
        sign_in user
      end

      it 'redirects to root' do
        test_redirect_to_root(new_project_url, nil)
      end
    end
  end

  describe 'GET /edit' do
    context 'when officer is logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end

      it 'renders a successful response' do
        project = Project.create! valid_project_attributes
        get edit_project_url(project)
        expect(response).to be_successful
      end
    end

    context 'when regular user is logged in' do
      let(:user) { User.create!(valid_attributes) }

      before do
        sign_in user
      end

      it 'redirects to root' do
        project = Project.create! valid_project_attributes
        test_redirect_to_root(edit_project_url(project), nil)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters and officer logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end

      it 'creates a new Project' do
        expect do
          post projects_url, params: { project: valid_project_attributes }
        end.to change(Project, :count).by(1)
      end

      it 'redirects to the created project' do
        post projects_url, params: { project: valid_project_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context 'with invalid parameters and officer logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end

      it 'does not create a new Project' do
        expect do
          post projects_url, params: { project: invalid_project_attributes }
        end.to change(Project, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post projects_url, params: { project: invalid_project_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters and officer logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end

      let(:new_attributes) do
        {
          projectName: 'New Test Project',
          projectDesc: 'This is a New Test Description.',
          projectStartDate: Date.tomorrow,
          locationID: 1,
          isProjectActive: false
        }
      end

      it 'updates the requested project' do
        project = Project.create! valid_project_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload

        expect(project.projectName).to eq('New Test Project')
        expect(project.projectDesc).to eq('This is a New Test Description.')
        expect(project.projectStartDate).to eq(Date.tomorrow) # Verify the date was updated
        expect(project.locationID).to eq(1)
        expect(project.isProjectActive).to eq(false)
      end

      it 'redirects to the project' do
        project = Project.create! valid_project_attributes
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(response).to redirect_to(project_url(project))
      end
    end

    context 'with invalid parameters and officer logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        project = Project.create! valid_project_attributes
        patch project_url(project), params: { project: invalid_project_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when officer is logged in' do
      let(:officer) { User.create!(valid_officer_attributes) }

      before do
        sign_in officer
      end
      it 'destroys the requested project' do
        project = Project.create! valid_project_attributes
        expect do
          delete project_url(project)
        end.to change(Project, :count).by(-1)
      end

      it 'redirects to the projects list' do
        project = Project.create! valid_project_attributes
        delete project_url(project)
        expect(response).to redirect_to(projects_url)
      end
    end
  end
end
