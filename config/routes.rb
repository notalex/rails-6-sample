Rails.application.routes.draw do
  get 'works' => 'home#works'
  get 'fails' => 'home#fails'
end
