## pilka


# Setup
docker-compose create

docker-compose start

rake db:create

rake db:migrate

rails s

#notatki
2.6.5 :002 > User.new
 => #<User id: nil, username: nil, created_at: nil, updated_at: nil> 

2.6.5 :004 > user = User.new
 => #<User id: nil, username: nil, created_at: nil, updated_at: nil> 
2.6.5 :005 > user
 => #<User id: nil, username: nil, created_at: nil, updated_at: nil> 
2.6.5 :006 > user.username = "Arkadiusz Karpinski"
 => "Arkadiusz Karpinski" 
2.6.5 :007 > user
 => #<User id: nil, username: "Arkadiusz Karpinski", created_at: nil, updated_at: nil> 
2.6.5 :008 > user.username = "Eryk"
 => "Eryk" 
2.6.5 :009 > user
 => #<User id: nil, username: "Eryk", created_at: nil, updated_at: nil> 
2.6.5 :010 > user.username = "Arkadiusz Karpinski"
 => "Arkadiusz Karpinski" 
2.6.5 :011 > user
 => #<User id: nil, username: "Arkadiusz Karpinski", created_at: nil, updated_at: nil> 
2.6.5 :012 > 


user = User.new
user.username = "Arek"
user.save
user # wyswietla uzytkownika


tworzenie użytkownika przez stronę w bazie danych:
routes.rb, users controolller def create, new html.rb

odczytywanie uzytkownikow z bazy danych :
def new
   @users = User.all

   typy danych: string, integer
   
   binding.pry zatrzymywanie kodu w konsoli
   

ZARCHIWIZOWANE AKCJE KONTROLERA:

def add_match
    user = User.find params["user_id"]
    user.match_count = user.match_count + 1
    user.save 
    
    redirect_to action: "index"
  end  

  def subtract_match
    user = User.find params["user_id"]
    user.match_count = user.match_count - 1
    if user.save
      #proceed
    else
      flash[:alert] = user.errors.full_messages.first

    end
      redirect_to action: "index"

  end

ZARCHIWIZOWANE TESTY:


it "adds match" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 0)
    user.save!

    get :add_match, params: { user_id: user.id }

    expect(user.reload.match_count).to eq 1
  end

  it "subtracts match" do
    user = User.new(username: "Olaf", goals_count: 0, match_count: 1)
    user.save!

    get :subtract_match, params: { user_id: user.id }

    expect(user.reload.match_count).to eq 0
  end

KONIEC


   git status
   git add -A
   git commit -am "lalala"
   git push
   git log
   git diff  -bez cached oglada czerwone ale tylko modyfikacje istniejacych juz plikow
   git diff --cached  - obejrzenie zmian, cached oglada zielone
   

User.all.map { |user| user.match_count = 0; user.save }  ustawianie match count dla kazdego uzytkownika


dodawanie goli do playera i sumowanie userowi

Player.all- obiekty i dane
Player.pluck(:goals_scored)- same dane

map- dla kazdego wykonuje nowy kod, tworzac nowa tablice(stara pozostaje niezmieniona)
map!- zastepuje stara tablice
save!- przy false blad wyskakuje 
puts- wyswietlanie na konsoli
to_a- upewnienie sie ze pojdzie zapytanie do bazy danych

cache

git push heroku main - aktualizacja apki
heroku logs --tail - sprawdza aktywnosc danego logowania
heroku run rake db:migrate - po aktualizacji apki migracja, zeby dzialala
heroku run rake data:fix - naprawa danych w apce z tasks.rake


def add_player_to_match
    match = Match.find params["match_id"]
    user = User.find params["user_id"]

    player = Player.where(match: match, user: user).first
    if player.nil?
      player = Player.new
      player.match = match
      player.user = user
      player.goals_scored = 0
      user.match_count = user.match_count + 1
      user.save
      player.save

      redirect_to action: "show", controller: "matches", match_id: match.id
    else
      flash[:alert] = "Player already added"
      redirect_to action: "show", controller: "matches", match_id: match.id
      
    end
  end

"match.team_1_name" -> string, zwykly napis

match.team_1_name -> kod ruby

 add refference match - belong to home squad, away squad dodac 2 kolumny
tabela matches ma miec 2 dodatkowe kolumny home_squad_id , away_squad_id do modelu squad

etap 1
dodanie meczu, tworzy sie mecz i 2 sklady
dodanie playera do meczu, player dodaje sie do skladu
rspec zielony

etap 2
migracja danych
do istniejacych meczow dodane sa sklady
istniejacy playerzy w bazie sa dodani do skladow

etap 3
sprzatanie, usuniecie niepotrzebnych kolumn, np.player.team_name
rspec zielony
  
  

