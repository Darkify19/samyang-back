Rails.application.routes.draw do
  get "sessions/new"
 
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end


  post "/graphql", to: "graphql#execute"
  
  post 'login', to: 'sessions#create'  # Handle user login
  delete 'logout', to: 'sessions#destroy'  # Handle user logout
  post 'graphql', to: 'graphql#execute'  # GraphQL endpoint
  # Root route pointing to login page
  
end
