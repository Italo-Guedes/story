import React, { useState } from 'react';
import { 
  Avatar, 
  Button,
  TextField, 
  Typography,
  Grid,
  CircularProgress
} from '@material-ui/core';
import { Link, useHistory } from 'react-router-dom'
import { makeStyles } from '@material-ui/core/styles';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import { toast } from 'react-toastify';
import AuthorizationClient from '../single-page/api/AuthorizationClient'
import FileField from '../components/FileField.js'
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
  wrapper: {
    margin: theme.spacing(1),
    position: 'relative',
  },
  buttonProgress: {
    color: 'white',
    position: 'absolute',
    top: '50%',
    left: '50%',
    marginTop: -12,
    marginLeft: -12,
  },
}));

export default function SignUp() {
  const classes = useStyles();
  const [user, setUser] = useState({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    avatar: ''
  });
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  let history = useHistory();
  
  function sign_up(e) {
    e.preventDefault();
    document.activeElement.blur();
    setLoading(true);
    toast.dismiss();

    // SIGN UP NÃO VEM HABILITADO POR PADRÃO NO TEMPLATE!
    
    AuthorizationClient.signUp(user)
      .then(function(){
        toast.success('Olhe sua caixa de e-mail para concluir o processo de cadastro');
        history.push("/public/sign_in");
      })
      .catch(function(response){
        if (response.status == 422){
          setErrors(response.data.errors);
        } else {
          setErrors({});
        }
        if (response.data && response.data.error) {
          toast.error(`Erro: ${response.data.error}`);
        } else {
          toast.error(`Erro ao processar solicitação.`);
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
        Criar minha conta
      </Typography>
      <form className={classes.form} onSubmit={sign_up} noValidate>
        <FileField 
          variant='outlined'
          name='avatar'
          fullWidth={true}
          id='avatar'
          label='Avatar'
          error={errors.avatar && true}
          helperText={errors.avatar ? errors.avatar.join(', ') : ''}
          value={user.avatar ? user.avatar.path : ''}
          onChange={(e) => setUser({...user, avatar: e.target.files[0] })}
        />
        {[
          { name: 'name', label: 'Nome', type: 'text', autoFocus: true, required: true },
          { name: 'email', label: 'Email', type: 'email', required: true },
          { name: 'password', label: 'Senha', type: 'password', required: true },
          { name: 'password_confirmation', label: 'Confirmação da senha', type: 'password', required: true }
        ].map((field) =>
          <TextField
            required={field.required}
            key={field.name}
            id={field.name}
            name={field.name}
            label={field.label}
            fullWidth={true}
            autoComplete={field.name}
            autoFocus={field.autoFocus}
            value={user[field.name]}
            error={errors[field.name] && true}
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
          Criar minha conta
        </LoadingButton>
      </form>
      <Grid container>
        <Grid item xs>
          <Link to="/public/sign_in" variant="body2">
            Entrar
          </Link>
        </Grid>
        <Grid item>
          <Link to="/public/request_password_reset" variant="body2">
            Esqueceu sua senha?
          </Link>
        </Grid>
      </Grid>
    </div>
  );
}