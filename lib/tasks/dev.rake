namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Apagando banco de dados...", "Concluído com sucesso!") {%x(rails db:drop)}
    show_spinner("Criando banco de dados...", "Concluído com sucesso!") {%x(rails db:create) }
    show_spinner("Migrando banco de dados...", "Concluído com sucesso!") {%x(rails db:migrate) }
    show_spinner("Semeando banco de dados...", "Concluído com sucesso!") { %x(rails db:seed) }

    else 
      puts "Você não está em desenvolvimento"
    end
  end

  private

  def show_spinner(msg_start, msg_end)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
     spinner.success("#{msg_end}")
  end

end
