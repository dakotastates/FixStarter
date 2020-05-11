json.extract! proposal, :id, :title, :content, :user_id, :problem_id, :created_at, :updated_at
json.url proposal_url(proposal, format: :json)
