namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Apagando banco de dados...", "Concluído com sucesso!") {%x(rails db:drop)}
    show_spinner("Criando banco de dados...", "Concluído com sucesso!") {%x(rails db:create) }
    show_spinner("Migrando banco de dados...", "Concluído com sucesso!") {%x(rails db:migrate) }
    %x(rails dev:add_mining_type) 
     %x(rails dev:add_coins) 
     

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
      url_image: "https://static.vecteezy.com/system/resources/previews/008/505/801/original/bitcoin-logo-color-illustration-png.png",
      mining_type: MiningType.where(acronym: 'PoW').first
      },
  
      {
      description: "Ethereum",
      acronym: "ETH",
      url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/1257px-Ethereum_logo_2014.svg.png",
      mining_type: MiningType.all.sample
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
        description: 'Proof of Work',
        acronym: "PoW"
    },
    {
      description: 'Proof of Stake',
      acronym: "PoS"
  },
  {
    description: 'Proof of Capacity',
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
