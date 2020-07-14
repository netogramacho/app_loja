import 'package:flutter/material.dart';
import 'package:loja_Teste/helpers/validators.dart';
import 'package:loja_Teste/models/user.dart';
import 'package:loja_Teste/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override 
  
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal:16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager> (builder: (_, userManager, __){
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Nome Completo'),
                    validator: (name){
                      if(name.isEmpty){
                        return 'Campo Obrigatório';
                      }
                      else if(name.trim().split(' ').length <= 1){
                        return 'Preencha seu nome completo';
                      }
                      return null;
                    },
                    onSaved: (name){
                      user.name = name;
                    },
                  ),
                  const SizedBox(height:16),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email){
                      if(email.isEmpty){
                        return 'Campo Obrigatório';
                      }
                      else if(!emailValid(email)){
                        return 'E-mail Inválido';
                      }
                      return null;
                    },
                    onSaved: (email){
                      user.email = email;
                    },
                  ),
                  const SizedBox(height:16),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (pass){
                      if(pass.isEmpty){
                        return 'Campo Obrigatório';
                      }
                      else if(pass.length < 6){
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass){
                      user.pass = pass;
                    },
                  ),
                  const SizedBox(height:16),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Repita a senha'),
                    obscureText: true,
                    validator: (pass){
                      if(pass.isEmpty){
                        return 'Campo Obrigatório';
                      }
                      else if(pass.length < 6){
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass){
                      user.confirmPass = pass;
                    },
                  ),
                  const SizedBox(height:16),
                  SizedBox(
                    height: 44,
                    child:  RaisedButton(
                      onPressed: userManager.loading ? null : (){
                        if(formKey.currentState.validate()){
                          formKey.currentState.save();

                          if(user.pass != user.confirmPass){
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: const Text('Senhas não coincidem',),
                                backgroundColor: Colors.red,
                              )  
                            );
                            return;
                          }
                          userManager.signUp(
                            user: user,
                            onSuccess:(){
                              Navigator.of(context).pushNamed('/base');
                            },
                            onFail: (e) {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Falha ao entrar: $e',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                )
                            );
                            }
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) :
                        const Text(
                          'Criar Conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}