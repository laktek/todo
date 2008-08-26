require File.dirname(__FILE__) + '/../lib/todo/store.rb'

describe "Todo::Store" do
  it "should read the YAML file and output Todo::List hash" do
    #list = {"Buy milk" => ["important", "home"]}
    #Todo::Store.read(list.to_yaml).should be_an_instance_of(Todo::List)
  end
  
  it "should output a modified YAML file"
end
