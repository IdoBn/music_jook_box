require 'spec_helper'

describe User do
  it { should have_many(:parties) }
  it { should have_many(:requests) }

  it 'should have method self.auth' do
  	user_auth = User.auth("CAAUJK8OBMJkBABjdumsZAFpZB7q63sEsWK6gnMZAZBoBZAv6LoZBdB1p87R7V3xFRx2NkqEjETyg7tgbqvVZBml9C721wTwsmPzaLp1qPF4rG6exbCZAfZBZBu2r7yMUZB95OwGrMTzdeVBEvmK9PUymO4SaqYBIXdGyc8BET5keZAGYqfeUHyErVysoJoe3Ah23ZC7vekvI3KDYLYwZDZD")['first_name']
  	expect(user_auth).to eq('Donna')
  end

  it 'creates user from omniauth with name' do
  	user = User.omniauth({ 
  				access_token: "CAAUJK8OBMJkBABjdumsZAFpZB7q63sEsWK6gnMZAZBoBZAv6LoZBdB1p87R7V3xFRx2NkqEjETyg7tgbqvVZBml9C721wTwsmPzaLp1qPF4rG6exbCZAfZBZBu2r7yMUZB95OwGrMTzdeVBEvmK9PUymO4SaqYBIXdGyc8BET5keZAGYqfeUHyErVysoJoe3Ah23ZC7vekvI3KDYLYwZDZD", expires_in: "5999"
  			})
  	expect(user.name).to eq("Donna Amhcjcfcjagh Fallerstein")
  end
end
