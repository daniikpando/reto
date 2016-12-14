class Product < ActiveRecord::Base
    include AASM
    has_many :comments
    belongs_to :user
    validates :name_product, presence: true
    validates :description_product,presence: true, length: { maximum: 10000000,minimum: 20 }

    has_attached_file :image, styles: {medium: '1280x720' ,  thumb: '800x600'}, default_url: "/assets/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    has_attached_file :video,styles: {medium: '1280x720' ,  thumb: '800x600'}
    validates_attachment_content_type :video,:content_type => ['video/mp4'],:message => "Sorry, right now we only support MP4 video"

    #scopes
    scope :published_products, -> { where(state: "published")}
    scope :unpublished_products, -> { where(state: "in_draft")}
    scope :order_desc_products, -> { order("created_at DESC")}
    scope :already_sold, -> { where(state: "sold")}
    #aasm gem
    aasm column: "state" do
		state :in_draft , initial: true
		state :published
        state :sold
		#Para cambiar de estado ponemos al final del metodo !
		# Para saber el estado actual de la columna ejecutamos may_ nombre_del_metodo con ? al final
		event :publish do
			transitions from: :in_draft , to: :published
		end
        event :sell do
            transitions from: :published, to: :sold
        end
		event :unpublish do
			transitions from: :published , to: :in_draft
		end
	end
    def update_state_of_selleing_to_sold
        self.update(selleing: "sold")
    end
    def increment_params
        self.update(like_product: self.like_product += 1)
    end
    def decrement_params
        self.update(dislike_product: self.dislike_product += 1)
    end
end
