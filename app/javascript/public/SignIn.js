import React, { useState } from 'react';
import { 
  Avatar, 
  Button,
  TextField, 
  FormControlLabel,
  Checkbox, 
  Typography,
  Grid
} from '@material-ui/core';
import { Link } from 'react-router-dom'
import { makeStyles } from '@material-ui/core/styles';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import AuthorizationClient from '../single-page/api/AuthorizationClient.js'
import { toast } from 'react-toastify'
import LoadingButton from '../components/LoadingButton.js'

const rdmcolor = '#D12E5E'

const useStyles = makeStyles((theme) => ({
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: rdmcolor,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
  paper: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
}));

export default function SignIn() {
  const classes = useStyles();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailError, setEmailError] = useState();
  const [passwordError, setPasswordError] = useState();
  const [loading, setLoading] = useState(false);

  function sign_in(e) {
    e.preventDefault();
    document.activeElement.blur();
    toast.dismiss();
    setLoading(true);
    AuthorizationClient.signIn({email: email, password: password})
      .then(function(){
        window.location.href = '/site?flash_notice=Login efetuado com sucesso!'
      })
      .catch(function(error){
        toast.error('Erro ao processar solicitação.');
        if (error.response.status == 401){
          setEmailError('Email ou senha inválidos');
        } else {
          setEmailError();
          // Tratar algum outro erro
        }
      })
      .then(function() {
        setLoading(false);
      });
  }

  return (
    <div className={classes.paper}>
      <Avatar className={classes.avatar}>
        <LockOutlinedIcon />
      </Avatar>
      <Typography component="h1" variant="h5">
        Entrar
      </Typography>
      <form className={classes.form} onSubmit={sign_in} noValidate>
        <TextField
          variant="outlined"
          margin="normal"
          required
          fullWidth
          label="Email"
          value={email}
          error={emailError}
          helperText={emailError}
          onChange={(e) => setEmail(e.target.value)}
          autoComplete="email"
          autoFocus
        />
        <TextField
          variant="outlined"
          margin="normal"
          required
          fullWidth
          value={password}
          error={passwordError}
          helperText={passwordError}
          onChange={(e) => setPassword(e.target.value)}
          label="Senha"
          type="password"
          autoComplete="current-password"
        />
        <FormControlLabel
          control={<Checkbox value="remember" color="primary" />}
          label="Lembre-se de mim"
        />

        <LoadingButton
          type="submit"
          fullWidth
          loading={loading}
          variant="contained"
          color="primary"
          className={classes.submit}
        >
          Entrar
        </LoadingButton>
      </form>
      <Grid container>
        <Grid item xs>
          <Link to="/public/request_password_reset" variant="body2">
            Esqueceu sua senha?
          </Link>
        </Grid>
        <Grid item>
          <Link variant="body2" to="/public/sign_up">
            Não possui uma conta? Cadastre-se
          </Link>
        </Grid>
      </Grid>
    </div>
  );
}