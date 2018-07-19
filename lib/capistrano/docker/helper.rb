module Capistrano
  module Docker
    module Helper
      def upload_dockerfile!
        template_path = fetch :dockerfile_template
        template = File.read template_path
        erb_template = ERB.new template
        dockerfile = erb_template.result binding
        remote_path = release_path.join 'Dockerfile'
        string_io = StringIO.new dockerfile
        upload! string_io, remote_path, mode: 0o644
      end

      def current_container
        capture :cat, 'tmp/pids/container.id'
      end

      def write_container(container)
        execute :echo, container, :>, 'tmp/pids/container.id'
      end

      def current_containers
        filter = "--filter=label=#{fetch :docker_filter_label}"
        options = '--format {{.ID}} --no-trunc'
        containers = capture :docker, :container, :list, filter, options
        containers.split("\n")
      end

      def volumes
        linked_dirs_files = fetch(:linked_files) + fetch(:linked_dirs)
        volumes = linked_dirs_files.flatten.map do |link|
          "--volume #{shared_path}/#{link}:#{fetch :docker_app_path}/#{link}"
        end
        volumes << "--volume #{shared_path}/bundle:#{fetch :bundle_path}"
      end
    end
  end
end
