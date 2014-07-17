require 'todo/store'

describe Todo::Store, 'read' do

  let(:filename) { ".todo/list.yml" }

  # TODO
  it "reads the todo/list.yml from the filesystem" do
    # store = class_double('Todo::Store')
    # expect(store).to receive(:read).with(filename)
    # store.read(filename)

    # file = class_double('File')
    # expect(file).to receive(:open).with(filename)
    # Todo::Store.read(filename)
  end

end
