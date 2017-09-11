RSpec.shared_examples_for :email_with_headers do
  it 'renders the sender email' do
    expect(email.from).to eq from
  end

  it 'renders the receiver email' do
    expect(email.to).to eq to
  end

  it 'renders the subject' do
    expect(email.subject).to eq subject
  end

  it 'renders the body' do
    expect(email.body.encoded).to match body
  end
end
