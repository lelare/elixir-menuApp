defmodule MenuAppWeb.PageLive do
  use Phoenix.LiveView

  @product_list [
    %{
      name: "Specialty Pizza",
      description: "Chicken Bacon Ranch",
      price: 8.9
    },
    %{
      name: "Third test product",
      description: "Third product description",
      price: 8.2
    },
    %{
      name: "Glazed Twist",
      description: "Crispy, glazed treats for a delicious twist on a classic",
      price: 5.9
    },
    %{
      name: "Fourth test product",
      description: "Fourth product description",
      price: 5.9
    },
    %{
      name: "One more test product",
      description: "One more product description",
      price: 8.9
    }
  ]

  # LiveView is mounted
  def mount(_params, _session, socket) do
    filtered_products = filter_products(@product_list)
    {:ok, assign(socket, products: filtered_products, selected_card: nil)}
  end

  defp filter_products(products) do
    Enum.filter(products, fn product ->
      !String.contains?(String.downcase(product.name), "test")
    end)
  end

  def handle_event("select_card", %{"name" => name}, socket) do
    {:noreply, assign(socket, selected_card: name)}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto pt-4 lg:pt-16">
      <h1>Menu</h1>
      <div class="flex gap-4 lg:gap-10 flex-col lg:flex-row lg:py-10">
        <%= for {product, index} <- Enum.with_index(@products) do %>
          <div id={"card-#{index}"} class={"card #{if product.name == @selected_card, do: "card--selected"}"} phx-click="select_card" phx-value-name={product.name} phx-hook="RippleHook">
            <span class="ripple"></span>
            <div class="mb-2.5 lg:mb-0">
              <h3 class="text-lg font-bold"><%= product.name %></h3>
              <p class="text-secondary font-medium"><%= product.description %></p>
            </div>
            <span class="card__price"><%= product.price %> &#8364;</span>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
