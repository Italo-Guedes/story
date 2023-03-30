class Rack::Attack

  ### Configure Cache ###
  # Implementa uma interface de armazenamento de cache
  #
  # ActiveSupport::Cache::Store 
  # Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ###  Configure Blocklist ###
  # O método pode ser usado para bloquear IPs específicos
  # que estejam tentando acessar o servidor.
  #
  # Rack::Attack.blocklist_ip("")

  #### Throttle all requests by IP (60rpm) ### 
  # Limita a taxa de requisições, o que significa que um único endereço
  # IP só pode fazer 60 requisições por minuto antes de ser
  # limitado pelo mecanismo de throttle
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  # throttle('req/ip', limit: 300, period: 5.minutes) do |req|
  #   req.ip
  # end

  ### Prevent Brute-Force Login Attacks ###
  # Bloqueia requisições POST para /login que excedam um limite
  # de 5 requisições por 20 segundos por endereço IP.
  #
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.ip
    end
  end

  ### Throttle POST requests to /login by email param ### 
  # Essa configuração de throttle limita o número de requisições
  # POST que um usuário pode fazer para a rota /login
  # com base no valor do parâmetro "email".
  #
  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.params['user']['email'].to_s.downcase.gsub(/\s+/, "").presence
    end
  end

  ### Custom Throttle Response ###
  # Método para personalizar a resposta do servidor
  # quando um usuário excede o limite de requisições
  # definido pelo mecanismo de throttle
  # (ou seja, de limitação de requisições).
  #
  # self.throttled_responder = lambda do |env|
  #  [ 503,  # status
  #    {},   # headers
  #    ['']] # body
  # end
end