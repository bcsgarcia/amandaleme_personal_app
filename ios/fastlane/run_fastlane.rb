# run_fastlane.rb

require 'dotenv'

# Carrega o arquivo .env
Dotenv.load('.env')

# Executa o comando do Fastlane
system("fastlane ios deploy")
# system("fastlane ios release_beta")
