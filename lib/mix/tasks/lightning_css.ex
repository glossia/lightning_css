defmodule Mix.Tasks.LightningCss do
  @shortdoc "Invokes lightning_css with the profile and args"
  @compile {:no_warn_undefined, Mix}

  @moduledoc """
  Runs lightning_css with the given profile and args.

  ```bash
  $ mix lightning_css --runtime-profile dev
  ```

  The task will install lightning_css if it hasn't been installed previously
  via the `mix lightning_css.install` task.

  ## Options

      * `--profile` - the profile to use.

  """

  use Mix.Task

  @impl true
  def run(args) do
    switches = [profile: :boolean]
    {opts, remaining_args} = OptionParser.parse_head!(args, switches: switches)

    if function_exported?(Mix, :ensure_application!, 1) do
      Mix.ensure_application!(:inets)
      Mix.ensure_application!(:ssl)
    end

    if opts[:profile] do
      Mix.Task.run("app.config")
    else
      Application.ensure_all_started(:lightning_css)
    end

    Mix.Task.reenable("lightning_css")
    install_and_run(remaining_args)
  end

  defp install_and_run([profile | args] = all) do
    case LightningCSS.install_and_run(String.to_atom(profile), args) do
      0 -> :ok
      status -> Mix.raise("`mix lightning_css #{Enum.join(all, " ")}` exited with #{status}")
    end
  end

  defp install_and_run([]) do
    Mix.raise("`mix lightning_css` expects the profile as argument")
  end
end
