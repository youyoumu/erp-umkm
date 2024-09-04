class Customer < ApplicationRecord
  validates :name, presence: {message: "Nama pembeli harus diisi"}
end
