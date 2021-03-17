import React, { useState } from 'react';
import { 
  Avatar, 
  Button,
  TextField, 
  Typography,
  Grid
} from '@material-ui/core';
import { Link } from 'react-router-dom'
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

export default function ResetPassword() {
  const classes = useStyles();
  const [user, setUser] = useState({
    password: '',
    password_confirmation: '',
  });
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  
  function reset_password(e) {
    e.preventDefault();
    document.activeElement.blur();
    toast.dismiss();
    setLoading(true);
    AuthorizationClient.resetPassword(user)
      .then(function(){
        window.location.href = '/site'
      })
      .catch(function(response){
        if (response.status == 422){
          setErrors(response.data.errors);
        } else {
          setErrors({});
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
      <form className={classes.form} onSubmit={reset_password} noValidate>
      {[
          { name: 'password', label: 'Senha', type: 'password', required: true },
          { name: 'password_confirmation', label: 'Confirmação da senha', type: 'password', required: true }
        ].map((field) =>
          <TextField
            required={field.required}
            key={field.name}
            id={field.name}
            fullWidth={true}
            name={field.name}
            label={field.label}
            autoComplete={field.name}
            autoFocus={field.autoFocus}
            value={user[field.name]}
            error={errors[field.name]}
            type={field.type}
            helperText={errors[field.name] ? errors[field.name].join(', ') : ''}
            onChange={(e) => setUser({...user, [field.name]: e.target.value})}
          />
        )}
        
        <LoadingButton
          type="submit"
          fullWidth
          loading={loading}
          variant="contained"
          color="primary"
          className={classes.submit}
        >
          Redefinir senha
        </LoadingButton>
      </form>
      <Grid container>
        <Grid item xs>
          <Link to="/public/sign_in" variant="body2">
            Entrar
          </Link>
        </Grid>
        <Grid item>
          <Link to="/public/sign_up" variant="body2">
            Não possui uma conta? Cadastre-se
          </Link>
        </Grid>
      </Grid>
    </div>
  );
}