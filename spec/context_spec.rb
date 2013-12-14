require 'spec_helper'


# initialize without parameters OK
# initialize with parameters    OK
# initialization expects a hash OK 
# initalize hash with symbol and string keys

# create dynamic getters and setters
# failure the context
# success the context
# use [] method to retrieve values


describe UseCase::Context do 


  it 'receives a hash and generate setters from key' do 
    hash = {name: 'thiago', last: 'dantas', github: 'tdantas'}
    context = described_class.new(hash)
    expect(context.name).to eql(hash[:name])
    expect(context.last).to eql(hash[:last])
    expect(context.github).to eql(hash[:github])
  end

  it 'initializes without parameters' do 
    expect(described_class.new).to be_an(described_class)
  end

  it 'raises exception when argument is not a hash' do 
    expect {described_class.new(Object.new)}.to raise_error(ArgumentError)
  end

  it 'assign new values' do 
    context = described_class.new
    context.dog_name = 'mali'
    context.country = 'lisbon'
    context.age = 1

    expect(context.dog_name).to eql('mali')
    expect(context.country).to eql('lisbon')
    expect(context.age).to eql(1)
  end

  it 'handle hash with indifference' do 
    hash = { "name" => 'thiago', last: 'dantas'}
    context = described_class.new(hash)
    expect(context.name).to eql('thiago')
    expect(context.last).to eql('dantas')
  end

  it 'is success when there is no error' do 
    context = described_class.new({})
    expect(context.success?).to eql(true)
  end

  it 'adds error messages to errors' do 
    context = described_class.new({})
    context.failure(:email, 'email already exist')
    expect(context.errors.length).to eql(1)
    expect(context.errors.first).to eql({ email: 'email already exist' })
  end

  it 'fails when exist errors' do
    context = described_class.new({})
    context.failure(:email, 'email already exist')
    expect(context.success?).to eql(false)
  end

end
