class AuthenticationsController < ApplicationController
  
  skip_before_filter :require_login, :only => [:loga, :desloga]
  
  def loga
    @service=Authentication.new
    login=Login.new
    login.cpf=params[:login]
    login.senha=params[:senha]
    @service.response=authenticate(login,true)
    
    respond_to do |format|
      format.xml { render xml: @service }
      format.json { render json: @service }
    end
  end
  
  def desloga
    @service=Authentication.new
    login=Login.new
    login.cpf=params[:login]
    @service.response=authenticate(login,false)
    
    respond_to do |format|
      format.xml { render xml: @service }
      format.json { render json: @service }
    end
  end
  
  def authenticate(login,logando)
    if(user=User.first(:conditions => "cpf = '#{login.cpf}' and senha = '#{login.senha}'"))
      case user.status
      when 2
        return -3
      when 4
        return -3
      when 3
        return -4
      else
        user.logado=logando
        user.save
        return 0
      end
    end
    if(user=User.find_by_cpf(login.cpf))
      if !logando
        if user.logado == false
          return -5
        else
          user.logado=logando
          user.save
          return 0
        end
      else
        return -2
      end
    else
      return -1
    end
    return -10
  end
end