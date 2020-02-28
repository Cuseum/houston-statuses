require "houston/statuses/engine"
require "houston/statuses/configuration"

module Houston
  module Statuses
    extend self

    def config(&block)
      @configuration ||= Statuses::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end

  navigation
    .add_link(:status_checks) { Houston::Statuses::Engine.routes.url_helpers.status_checks_path }
    .name("Status checks")
    .ability { can?(:read, Statuses::StatusCheck) }


  # Extension Points
  # ===========================================================================
  #
  # Read more about extending Houston at:
  # https://github.com/houston/houston-core/wiki/Modules


  # Register events that will be raised by this module
  #
  #    register_events {{
  #      "statuses:create" => params("statuses").desc("Statuses was created"),
  #      "statuses:update" => params("statuses").desc("Statuses was updated")
  #    }}

  register_events {{
    "status_checks:enqueue" => params('id').desc('Status check was enqueued'),
    "status_checks:checked" => params('id').desc('Status check was checked'),
  }}


  # Add a link to Houston's global navigation
  #
  #    add_navigation_renderer :statuses do
  #      name "Statuses"
  #      path { Houston::Statuses::Engine.routes.url_helpers.statuses_path }
  #      ability { |ability| ability.can? :read, Project }
  #    end

  # Add a link to feature that can be turned on for projects
  #
  #    add_project_feature :statuses do
  #      name "Statuses"
  #      path { |project| Houston::Statuses::Engine.routes.url_helpers.project_statuses_path(project) }
  #      ability { |ability, project| ability.can? :read, project }
  #    end

  Houston.config.on "status_checks:enqueue" => "status_checks:run_check" do
    Houston::Statuses::StatusCheckRunner.new(id).call
  end
end
