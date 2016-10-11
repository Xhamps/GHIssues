defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir xhamps@gmail.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, reponse }), do: { :ok, :jsx.decode(reponse.body) }
  def handle_response({ :error, reponse }), do: { :error, :jsx.decode(reponse.body) }
end