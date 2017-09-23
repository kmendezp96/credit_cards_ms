docker-compose build
docker-compose run --rm credit_cards_ms rails db:create
docker-compose run --rm credit_cards_ms rails db:migrate
docker-compose up
