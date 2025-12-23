const { createApp } = Vue;

createApp({
    data() {
        return {
            showShop: false,
            shopData: {},
            playerData: {},
            selectedCategory: 'all',
            searchQuery: '',
            cart: [],
            showCart: false,
            paymentMethod: 'cash',
            searchResults: []
        }
    },
    
    computed: {
        filteredItems() {
            let items = [];
            
            if (this.selectedCategory === 'all') {
                this.shopData.categories?.forEach(category => {
                    items.push(...category.items);
                });
            } else {
                const selectedCat = this.shopData.categories?.find(cat => cat.id === this.selectedCategory);
                if (selectedCat) {
                    items = [...selectedCat.items];
                }
            }
            
            if (this.searchQuery.trim()) {
                const query = this.searchQuery.toLowerCase();
                return items.filter(item => 
                    item.label.toLowerCase().includes(query) ||
                    item.name.toLowerCase().includes(query)
                );
            }
            
            return items;
        },
        
        cartTotals() {
            let regular = 0;
            let vip = 0;
            
            this.cart.forEach(item => {
                if (item.isVip) {
                    vip += item.vipPrice * item.quantity;
                } else {
                    regular += item.price * item.quantity;
                }
            });
            
            return { regular, vip };
        },
        
        canCheckout() {
            if (this.cart.length === 0) return false;
            
            const totals = this.cartTotals;
            
            if (totals.vip > 0 && this.playerData.vCoins < totals.vip) {
                return false;
            }
            
            if (totals.regular > 0) {
                if (this.shopData.type === 'illegal') {
                    return this.playerData.blackMoney >= totals.regular;
                } else {
                    if (this.paymentMethod === 'cash') {
                        return this.playerData.money >= totals.regular;
                    } else if (this.paymentMethod === 'bank') {
                        return this.playerData.bank >= totals.regular;
                    }
                }
            }
            
            return true;
        }
    },
    
    methods: {
        formatNumber(num) {
            return new Intl.NumberFormat('en-US').format(num);
        },
        
        getLogoUrl(marketType) {
            const logos = {
                'regular': 'https://cdn-icons-png.flaticon.com/512/3081/3081559.png',
                'ltd': 'https://cdn-icons-png.flaticon.com/512/2972/2972185.png',
                'liquor': 'https://cdn-icons-png.flaticon.com/512/920/920581.png',
                'illegal': 'https://cdn-icons-png.flaticon.com/512/1828/1828843.png'
            };
            return logos[marketType] || logos['regular'];
        },
        
        handleImageError(event) {
            event.target.style.display = 'none';
        },
        
        performSearch() {
            if (!this.searchQuery.trim()) {
                this.searchResults = [];
                return;
            }
            
            const query = this.searchQuery.toLowerCase();
            let allItems = [];
            
            this.shopData.categories?.forEach(category => {
                allItems.push(...category.items);
            });
            
            this.searchResults = allItems.filter(item => 
                item.label.toLowerCase().includes(query) ||
                item.name.toLowerCase().includes(query)
            );
        },
        
        addToCart(item) {
            const existingItem = this.cart.find(cartItem => cartItem.item === item.name);
            
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                this.cart.push({
                    item: item.name,
                    label: item.label,
                    price: item.price,
                    vipPrice: item.vipPrice,
                    isVip: item.isVip,
                    quantity: 1
                });
            }
        },
        
        updateCartQuantity(index, change) {
            const item = this.cart[index];
            item.quantity += change;
            
            if (item.quantity <= 0) {
                this.cart.splice(index, 1);
            }
        },
        
        removeFromCart(index) {
            this.cart.splice(index, 1);
        },
        
        checkout() {
            if (!this.canCheckout) return;
            
            const purchaseData = {
                items: this.cart.map(item => ({
                    item: item.item,
                    quantity: item.quantity
                })),
                paymentMethod: this.paymentMethod,
                totalPrice: this.cartTotals.regular + this.cartTotals.vip
            };
            
            fetch(`https://${GetParentResourceName()}/buyItems`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(purchaseData)
            })
            .then(response => response.json())
            .then(success => {
                if (success) {
                    this.cart = [];
                    this.showCart = false;
                    
                    this.showSuccessAnimation();
                } else {
                    console.error('Purchase failed');
                }
            });
        },
        
        showSuccessAnimation() {
            const tablet = document.querySelector('.market-tablet');
            if (tablet) {
                tablet.style.boxShadow = '0 0 100px rgba(16, 185, 129, 0.3)';
                setTimeout(() => {
                    tablet.style.boxShadow = '';
                }, 1000);
            }
        },
        
        closeShop() {
            fetch(`https://${GetParentResourceName()}/closeShop`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            });
        }
    },
    
    mounted() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            switch (data.type) {
                case 'openShop':
                    this.showShop = true;
                    this.shopData = data.shopData;
                    this.playerData = data.playerData;
                    this.selectedCategory = 'all';
                    this.searchQuery = '';
                    this.searchResults = [];
                    this.cart = [];
                    this.showCart = false;
                    this.paymentMethod = 'cash';
                    break;
                    
                case 'closeShop':
                    this.showShop = false;
                    this.shopData = {};
                    this.playerData = {};
                    break;
                    
                case 'updatePlayerData':
                    this.playerData = data.playerData;
                    break;
            }
        });
        
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                if (this.showCart) {
                    this.showCart = false;
                } else if (this.showShop) {
                    fetch(`https://${GetParentResourceName()}/closeShop`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({})
                    });
                    this.showShop = false;
                }
            }
        });
    }
}).mount('#app');