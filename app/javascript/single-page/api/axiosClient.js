import axios from 'axios';

const axiosClient = axios.create({
  baseURL: ''
});

// NOTE: Pede json como retorno
axiosClient.defaults.headers.common['Accept'] = 'application/json';

// NOTE: Qualquer header pode ser configurado para ser utilizado sempre
// mainAxios.defaults.headers.common['api-key'] = 'abc';

// NOTE:
// Esta configuração monitora as respostas das requisições
// Se receber alguma resposta com status 401 entendo que o usuário não está logado a API
// Sendo assim redireciono a página para a rota ROOT, Onde está a página de login
axiosClient.interceptors.response.use(function (response) {
  console.debug('Request Successful!', response);
  return response.data;
}, function (error) {
  console.error('Request Failed:', error.config);

  if (error.response) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx
    console.log(error.response.data);
    console.log(error.response.status);
    console.log(error.response.headers);
    if (error.response.status === 401) {
      window.location = '/public';
    }
  } else if (error.request) {
    // The request was made but no response was received
    // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
    // http.ClientRequest in node.js
    // if (error.message == 'Network Error') {
      // You can treat network error globally here
    // }
    console.log(error.message);
    console.log(error.request);
  } else {
    // Something happened in setting up the request that triggered an Error
    console.log('Error', error.message);
  }
  
  return Promise.reject(error.response || error.message);
});

export default axiosClient;