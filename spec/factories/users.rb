# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	uid "100008303630178"
  	name "Donna Amhcjcfcjagh Fallerstein"
  	email "dasfttm_fallerstein_1400277263@tfbnw.net"
  	oauth_token "CAAUJK8OBMJkBABjdumsZAFpZB7q63sEsWK6gnMZAZBoBZAv6LoZBdB1p87R7V3xFRx2NkqEjETyg7tgbqvVZBml9C721wTwsmPzaLp1qPF4rG6exbCZAfZBZBu2r7yMUZB95OwGrMTzdeVBEvmK9PUymO4SaqYBIXdGyc8BET5keZAGYqfeUHyErVysoJoe3Ah23ZC7vekvI3KDYLYwZDZD"
  	oauth_expires_at 1.hour.from_now
  end
end
