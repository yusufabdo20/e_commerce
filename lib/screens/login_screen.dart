import 'package:e_commerce/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              BlocConsumer<AuthCubit, AuthStates>(
                builder: (context, state) {
                  if (state is LoginInitial) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(
                              userEmail: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: const Text('Login'),
                    );
                  } else if (state is LoginLoading) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  } else if (state is LoginSuccess) {
                    return const Center(
                      child: Icon(
                        Icons.check,
                        size: 100,
                      ),
                    );
                  } else {
                    return state is LoginError
                        ? Text(state.error)
                        : const Icon(
                            Icons.access_alarm,
                            size: 100,
                          );
                  }
                },
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.blue,
    );
  }
}
