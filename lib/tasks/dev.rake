namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Apagando banco de dados...", "Concluído com sucesso!") {%x(rails db:drop)}
    show_spinner("Criando banco de dados...", "Concluído com sucesso!") {%x(rails db:create) }
    show_spinner("Migrando banco de dados...", "Concluído com sucesso!") {%x(rails db:migrate) }
     %x(rails dev:add_coins) 
     %x(rails dev:add_mining_type) 

    else 
      puts "Você não está em desenvolvimento"
    end
  end

  desc "Cadastrar moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...", "Concluído com sucesso!") do
    coins = [  {
      description: "Bitcoin",
      acronym: "BTC",
      url_image: "https://static.vecteezy.com/system/resources/previews/008/505/801/original/bitcoin-logo-color-illustration-png.png"
      },
  
      {
      description: "Ethereum",
      acronym: "ETH",
      url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/1257px-Ethereum_logo_2014.svg.png"
      }]
  
      coins.each do |coin| 
          Coin.find_or_create_by!(coin)
      end
    end
end

desc "Cadastrar do tipo de mineração"
task add_mining_type: :environment do
  show_spinner("Cadastrando tipo de mineração...", "Concluído com sucesso!") do
    mining_types = [{
        name: 'Proof of Work',
        acronym: "PoW"
    },
    {
      name: 'Proof of Stake',
      acronym: "PoS"
  },
  {
    name: 'Proof of Capacity',
    acronym: "PoC"
}
    ]

    mining_types.each do |mining| 
      MiningType.find_or_create_by!(mining)
  end
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
