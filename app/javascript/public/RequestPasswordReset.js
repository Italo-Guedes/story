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
import { Link, useHistory } from 'react-router-dom'
import { makeStyles } from '@material-ui/core/styles';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import { toast } from 'react-toastify';
import AuthorizationClient from '../single-page/api/AuthorizationClient'
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
    width: '100%',
    flexDirection: 'column',
    alignItems: 'center',
  },
}));

export default function RequestPasswordReset() {
  const classes = useStyles();
  const [email, setEmail] = useState('');
  const [emailError, setEmailError] = useState();
  const history = useHistory();
  const [loading, setLoading] = useState(false);
  
  function requestPasswordReset(e) {
    e.preventDefault();
    document.activeElement.blur();
    toast.dismiss();
    setLoading(true);
    AuthorizationClient.requestPasswordReset({ email: email })
      .then(function(res){
        toast.success('Olhe sua caixa de e-mail para concluir o processo');
        history.push("/public/sign_in");
      })
      .catch(function(response){
        if (response.status == 422){
          setEmailError(response.data.errors.email.join(', '));
        } else {
          setEmailError();
        }
        if (response.data.error) {
          toast.error(`Erro: ${response.data.error}`);
        } else {
          toast.error('Erro ao processar solicitação.');
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
        Recuperar minha senha
      </Typography>
      <form className={classes.form} onSubmit={requestPasswordReset} noValidate>
        <TextField
          required
          id="email"
          label="Email"
          name="email"
          fullWidth={true}
          value={email}
          error={emailError}
          helperText={emailError}
          onChange={(e) => setEmail(e.target.value)}
          autoComplete='email'
          autoFocus
        />

        <LoadingButton
          type="submit"
          fullWidth
          loading={loading}
          variant="contained"
          color="primary"
          className={classes.submit}
        >
          Recuperar minha senha
        </LoadingButton>
      </form>
      <Grid container>
        <Grid item xs>
          <Link variant="body2" to="/public/sign_in">
            Entrar
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