require 'todo/controller'

RSpec.describe 'Todo::Controller' do

  let(:filename) { ".todo.yml" }

  let(:empty_task_list) { [] }
  let(:created_at) { Time.now.to_s }
  let(:one_todo_item) { [{ "taskid"=>"123abc",
                           "created_at"=>created_at,
                           "description"=>":-)",
                           "tags"=>[]}] }
  let(:new_task_list) { [
                         { "taskid"=>"123abc",
                           "created_at"=>created_at,
                           "description"=>":-)",
                           "tags"=>[] },
                         { "taskid"=>"456def",
                           "created_at"=>created_at,
                           "description"=>":-D",
                           "tags"=>[] },
                        ] }

  context "add task" do
    it "should create the file if it does not exist" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(empty_task_list)
      expect(Todo).to receive(:save_tasks).with(filename,one_todo_item).and_return(true)
      expect(Todo::add_task(filename,true,":-)","123abc",created_at)).to eq("<%= color('Task added', :green) %>")
    end

    it "should add another task to the existing ones" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(one_todo_item)
      expect(Todo).to receive(:save_tasks).with(filename,new_task_list).and_return(true)
      expect(Todo::add_task(filename,true,":-D","456def")).to eq("<%= color('Task added', :green) %>")
    end
  end

  context "del task" do
    it "should delete a task" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(new_task_list)
      expect(Todo).to receive(:save_tasks).with(filename,one_todo_item).and_return(true)
      expect(Todo::del_task(filename,2)).to eq("<%= color('Task deleted', :yellow) %>")
    end

    it "should delete nothing if wrong index" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(new_task_list)
      expect(Todo).not_to receive(:save_tasks).with(any_args)
      expect(Todo::del_task(filename,99)).to eq("<%= color('No task deleted', :red) %>")
    end
  end

  context "show tasks" do
    it "should show nothing when no tasks in the list" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(empty_task_list)
      expect(Todo::show_tasks(filename,nil)).to eq("Listing tasks (all)\n")
    end

    it "should show all tasks when no tag given" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(one_todo_item)
      final = "Listing tasks (all)\n(1)\n\t taskid      : 123abc\n\t created_at  : #{created_at}\n\t description : <%= color(':-)', :yellow) %>\n"
      expect(Todo::show_tasks(filename,nil)).to eq(final)
    end

    it "should show only tagged tasks when tag given" do
      expect(Todo).to receive(:load_tasks).with(filename).and_return(new_task_list)
      expect(Todo::show_tasks(filename,["a"])).to eq("Listing tasks ([\"a\"])\n")
    end
  end

end
