%%%-------------------------------------------------------------------
%% @doc erl_jenkins_example public API
%% @end
%%%-------------------------------------------------------------------

-module(erl_jenkins_example_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        { '_', [
            {'_', a_handler, []}] }
    ]),
    {ok, _} = cowboy:start_clear(
        a_listener,
        [{port, 8081}],
        #{env => #{dispatch => Dispatch}}
    ),
    erl_jenkins_example_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
