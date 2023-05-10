module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?s=#{opts.delete(:size) { 100 }}", opts
  end

  def thumb(attachment)
    (attachment.variable? ? attachment.variant(auto_orient: true, resize: '200>') : attachment) if attachment&.present? || attachment&.any?
  end

  def square_thumb(attachment)
    attachment.variable? ? attachment.variant(auto_orient: true, resize: '200x200^', gravity: 'Center', crop: '200x200+0+0') : attachment if attachment&.present? || attachment&.any?
  end
end
