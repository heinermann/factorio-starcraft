
#include "bwenums.h"

#include <algorithm>
#include <utility>
#include <cstdlib>
#include <cmath>
#include <functional>
#include <optional>

#include <cstdint>
#include <deque>
#include <map>
#include <list>
#include <iterator>
#include <limits>
#include <array>
#include <type_traits>
#include <stdexcept>

namespace bwgame {

	template<typename T, std::pair<T*, T*> T::* link_ptr>
	struct intrusive_list_member_link {
		std::pair<T*, T*>* operator()(T* ptr) const {
			return &(ptr->*link_ptr);
		}
		const std::pair<T*, T*>* operator()(const T* ptr) const {
			return &(ptr->*link_ptr);
		}
	};

	template<typename T, typename link_T, std::pair<T*, T*> T::* link_ptr = nullptr>
	class intrusive_list {
		using link_f = std::conditional_t<link_ptr == nullptr, link_T, intrusive_list_member_link<T, link_ptr>>;
	public:
		typedef T value_type;
		typedef size_t size_type;
		typedef ptrdiff_t difference_type;
		typedef T& reference;
		typedef const T& const_reference;
		typedef T* pointer;
		typedef const T* const_pointer;

		class const_iterator {
		public:
			typedef std::bidirectional_iterator_tag iterator_category;
			typedef typename intrusive_list::value_type value_type;
			typedef typename intrusive_list::difference_type difference_type;
			typedef typename intrusive_list::const_pointer pointer;
			typedef typename intrusive_list::const_reference reference;
		private:
			typedef const_iterator this_t;
			pointer ptr = nullptr;
		public:
			const_iterator() = default;
			explicit const_iterator(pointer ptr) : ptr(ptr) {}
			explicit const_iterator(reference v) : ptr(&v) {}
			reference operator*() const {
				return *ptr;
			}
			pointer operator->() const {
				return ptr;
			}
			this_t& operator++() {
				ptr = link_f()(ptr)->second;
				return *this;
			}
			this_t operator++(int) {
				auto r = *this;
				ptr = link_f()(ptr)->second;
				return r;
			}
			this_t& operator--() {
				ptr = link_f()(ptr)->first;
				return *this;
			}
			this_t operator--(int) {
				auto r = *this;
				ptr = link_f()(ptr)->first;
				return r;
			}
			bool operator==(const this_t& rhs) const {
				return ptr == rhs.ptr;
			}
			bool operator!=(const this_t& rhs) const {
				return !(*this == rhs);
			}
		};

		class iterator {
		public:
			typedef std::bidirectional_iterator_tag iterator_category;
			typedef typename intrusive_list::value_type value_type;
			typedef typename intrusive_list::difference_type difference_type;
			typedef typename intrusive_list::pointer pointer;
			typedef typename intrusive_list::reference reference;
		private:
			typedef iterator this_t;
			pointer ptr = nullptr;
		public:
			iterator() = default;
			explicit iterator(pointer ptr) : ptr(ptr) {}
			explicit iterator(reference v) : ptr(&v) {}
			reference operator*() const {
				return *ptr;
			}
			pointer operator->() const {
				return ptr;
			}
			this_t& operator++() {
				ptr = link_f()(ptr)->second;
				return *this;
			}
			this_t operator++(int) {
				auto r = *this;
				ptr = link_f()(ptr)->second;
				return r;
			}
			this_t& operator--() {
				ptr = link_f()(ptr)->first;
				return *this;
			}
			this_t operator--(int) {
				auto r = *this;
				ptr = link_f()(ptr)->first;
				return r;
			}
			bool operator==(const this_t& rhs) const {
				return ptr == rhs.ptr;
			}
			bool operator!=(const this_t& rhs) const {
				return !(*this == rhs);
			}
		};

		typedef std::reverse_iterator<iterator> reverse_iterator;
		typedef std::reverse_iterator<const_iterator> const_reverse_iterator;

	private:
		std::pair<T*, T*> header = { &*end(), &*end() };
		pointer ptr_begin() const {
			return header.second;
		}
		pointer ptr_end() const {
			uint8_t* p = (uint8_t*)&header;
			p -= (intptr_t)link_f()((T*)nullptr);
			return (T*)p;
		}
		pointer ptr_front() const {
			return header.second;
		}
		pointer ptr_back() const {
			return header.first;
		}
	public:
		intrusive_list() = default;
		intrusive_list(const intrusive_list&) = delete;
		intrusive_list(intrusive_list&& n) noexcept {
			*this = std::move(n);
		}
		intrusive_list& operator=(const intrusive_list& n) = delete;
		intrusive_list& operator=(intrusive_list&& n) noexcept {
			if (n.empty()) clear();
			else {
				header = n.header;
				n.clear();
				link_f()(ptr_front())->first = ptr_end();
				link_f()(ptr_back())->second = ptr_end();
			}
			return *this;
		}
		reference front() {
			return *ptr_front();
		}
		const_reference front() const {
			return *ptr_front();
		}
		reference back() {
			return *ptr_back();
		}
		const_reference back() const {
			return *ptr_back();
		}
		iterator begin() {
			return iterator(ptr_begin());
		}
		const_iterator begin() const {
			return const_iterator(ptr_begin());
		}
		const_iterator cbegin() const {
			return const_iterator(ptr_begin());
		}
		iterator end() {
			return iterator(ptr_end());
		}
		const_iterator end() const {
			return const_iterator(ptr_end());
		}
		const_iterator cend() const {
			return const_iterator(ptr_end());
		}
		reverse_iterator rbegin() {
			return reverse_iterator(end());
		}
		const_reverse_iterator rbegin() const {
			return reverse_iterator(end());
		}
		const_reverse_iterator crbegin() const {
			return reverse_iterator(end());
		}
		reverse_iterator rend() {
			return reverse_iterator(begin());
		}
		const_reverse_iterator rend() const {
			return reverse_iterator(begin());
		}
		const_reverse_iterator crend() const {
			return reverse_iterator(begin());
		}
		bool empty() const {
			return ptr_begin() == ptr_end();
		}
		size_type size() const = delete;
		constexpr size_type max_size() const = delete;
		void clear() {
			header = { ptr_end(), ptr_end() };
		}
		iterator insert(iterator pos, reference v) {
			pointer before = &*pos;
			pointer after = link_f()(before)->first;
			link_f()(before)->first = &v;
			link_f()(after)->second = &v;
			link_f()(&v)->first = after;
			link_f()(&v)->second = before;
			return iterator(v);
		}
		iterator erase(iterator pos) {
			pointer ptr = &*pos;
			pointer prev = link_f()(ptr)->first;
			pointer next = link_f()(ptr)->second;
			link_f()(prev)->second = next;
			link_f()(next)->first = prev;
			return iterator(*next);
		}
		void remove(reference v) {
			erase(iterator(v));
		}
		void push_back(reference v) {
			insert(end(), v);
		}
		void pop_back() {
			erase(iterator(back()));
		}
		void push_front(reference v) {
			insert(begin(), v);
		}
		void pop_front() {
			erase(iterator(front()));
		}
		void swap(intrusive_list& n) noexcept {
			if (empty()) {
				if (n.empty()) return;
				header = n.header;
				n.clear();
				link_f()(ptr_front())->first = ptr_end();
				link_f()(ptr_back())->second = ptr_end();
			}
			else if (n.empty()) {
				n.header = header;
				clear();
				link_f()(n.ptr_front())->first = n.ptr_end();
				link_f()(n.ptr_back())->second = n.ptr_end();
			}
			else {
				std::swap(header, n.header);
				link_f()(n.ptr_front())->first = n.ptr_end();
				link_f()(n.ptr_back())->second = n.ptr_end();
				link_f()(ptr_front())->first = ptr_end();
				link_f()(ptr_back())->second = ptr_end();
			}
		}
		iterator iterator_to(reference v) {
			return iterator(v);
		}
		static iterator s_iterator_to(reference v) {
			return iterator(v);
		}
	};

}

namespace bwgame {

	template<typename utype>
	struct xy_t {
		utype x{};
		utype y{};
		xy_t() = default;
		xy_t(utype x, utype y) : x(x), y(y) {}
		bool operator<(const xy_t& n) const {
			if (y == n.y) return x < n.x;
			return y < n.y;
		}
		bool operator>(const xy_t& n) const {
			if (y == n.y) return x > n.x;
			return y > n.y;
		}
		bool operator<=(const xy_t& n) const {
			if (y == n.y) return x <= n.x;
			return y <= n.y;
		}
		bool operator>=(const xy_t& n) const {
			if (y == n.y) return x >= n.x;
			return y >= n.y;
		}
		bool operator==(const xy_t& n) const {
			return x == n.x && y == n.y;
		}
		bool operator!=(const xy_t& n) const {
			return x != n.x || y != n.y;
		}
		xy_t operator-(const xy_t& n) const {
			xy_t r(*this);
			return r -= n;
		}
		xy_t& operator-=(const xy_t& n) {
			x -= n.x;
			y -= n.y;
			return *this;
		}
		xy_t operator+(const xy_t& n) const {
			xy_t r(*this);
			return r += n;
		}
		xy_t& operator+=(const xy_t& n) {
			x += n.x;
			y += n.y;
			return *this;
		}
		xy_t operator -() const {
			return xy_t(-x, -y);
		}
		xy_t operator/(const xy_t& n) const {
			xy_t r(*this);
			return r /= n;
		}
		xy_t& operator/=(const xy_t& n) {
			x /= n.x;
			y /= n.y;
			return *this;
		}
		template<typename T>
		xy_t operator/(T&& v) const {
			return xy_t(*this) /= v;
		}
		template<typename T>
		xy_t& operator/=(T&& v) {
			x /= v;
			y /= v;
			return *this;
		}
		xy_t operator*(const xy_t& n) const {
			xy_t r(*this);
			return r *= n;
		}
		xy_t& operator*=(const xy_t& n) {
			x *= n.x;
			y *= n.y;
			return *this;
		}
		template<typename T>
		xy_t operator*(T&& v) const {
			return xy_t(*this) *= v;
		}
		template<typename T>
		xy_t& operator*=(T&& v) {
			x *= v;
			y *= v;
			return *this;
		}
	};

	template<typename T>
	struct rect_t {
		T from;
		T to;
		rect_t() = default;
		rect_t(T from, T to) : from(from), to(to) {}
		bool operator==(const rect_t& n) const {
			return from == n.from && to == n.to;
		}

		rect_t operator+(const rect_t& n) const {
			return { from + n.from, to + n.to };
		}

		int x() {
			return std::min(from.x, to.x);
		}

		int y() {
			return std::min(from.y, to.y);
		}

		int width() {
			return std::abs(to.x - from.x);
		}

		int height() {
			return std::abs(to.y - from.y);
		}
	};

	template<typename iter_T>
	struct iterators_range {
	private:
		iter_T begin_it;
		iter_T end_it;
	public:
		iterators_range(iter_T begin_it, iter_T end_it) : begin_it(begin_it), end_it(end_it) {}

		using iterator = iter_T;

		using value_type = typename std::iterator_traits<iterator>::value_type;
		using pointer = typename std::iterator_traits<iterator>::pointer;
		using reference = typename std::iterator_traits<iterator>::reference;

		iterator begin() {
			return begin_it;
		}
		iterator end() {
			return end_it;
		}

		bool empty() const {
			return begin_it == end_it;
		}

		reference front() {
			return *begin_it;
		}

	};


	template<typename iter_T>
	iterators_range<iter_T> make_iterators_range(iter_T begin, iter_T end) {
		return iterators_range<iter_T>(begin, end);
	}

	template<typename iterator_T, typename transform_F>
	struct transform_iterator {
	private:
		typedef transform_iterator this_t;
		iterator_T ptr;
		transform_F f;
	public:
		using iterator_category = typename std::iterator_traits<iterator_T>::iterator_category;
		using reference = typename std::result_of<transform_F(typename std::iterator_traits<iterator_T>::reference)>::type;
		using value_type = typename std::remove_cv<typename std::remove_const<reference>::type>::type;
		using difference_type = typename std::iterator_traits<iterator_T>::difference_type;
		using pointer = typename std::remove_reference<reference>::type*;

		template<typename arg_iterator_T, typename arg_transform_F>
		transform_iterator(arg_iterator_T&& ptr, arg_transform_F&& f) : ptr(std::forward<arg_iterator_T>(ptr)), f(std::forward<arg_transform_F>(f)) {}

		reference operator*() const {
			return f(*ptr);
		}
		reference operator*() {
			return f(*ptr);
		}
		this_t& operator++() {
			++ptr;
			return *this;
		}
		this_t operator++(int) {
			auto r = *this;
			++ptr;
			return r;
		}
		this_t& operator--() {
			--ptr;
			return *this;
		}
		this_t operator--(int) {
			auto r = *this;
			--ptr;
			return r;
		}
		this_t& operator+=(difference_type diff) {
			ptr += diff;
			return *this;
		}
		this_t operator+(difference_type diff) const {
			auto r = *this;
			return r += diff;
		}
		this_t& operator-=(difference_type diff) {
			ptr -= diff;
			return *this;
		}
		this_t operator-(difference_type diff) const {
			auto r = *this;
			return r -= diff;
		}
		difference_type operator-(const this_t& other) const {
			return ptr - other.ptr;
		}
		bool operator==(const this_t& rhs) const {
			return ptr == rhs.ptr;
		}
		bool operator!=(const this_t& rhs) const {
			return ptr != rhs.ptr;
		}
		bool operator<(const this_t& rhs) const {
			return ptr < rhs.ptr;
		}
		bool operator<=(const this_t& rhs) const {
			return ptr <= rhs.ptr;
		}
		bool operator>(const this_t& rhs) const {
			return ptr > rhs.ptr;
		}
		bool operator>=(const this_t& rhs) const {
			return ptr >= rhs.ptr;
		}
	};

	template<typename iterator_T, typename transform_F>
	auto make_transform_iterator(iterator_T&& c, transform_F&& f) {
		return transform_iterator<iterator_T, transform_F>(std::forward<iterator_T>(c), std::forward<transform_F>(f));
	}

	template<typename range_T, typename transform_F>
	auto make_transform_range(range_T&& r, transform_F&& f) {
		auto begin = make_transform_iterator(r.begin(), std::forward<transform_F>(f));
		return make_iterators_range(begin, make_transform_iterator(r.end(), std::forward<transform_F>(f)));
	}

	template<typename iterator_T, typename predicate_F>
	struct filter_iterator {
	private:
		typedef filter_iterator this_t;
		iterator_T ptr;
		iterator_T end_ptr;
		predicate_F f;
	public:
		using iterator_category = std::forward_iterator_tag;
		using reference = typename std::iterator_traits<iterator_T>::reference;
		using value_type = typename std::iterator_traits<iterator_T>::value_type;
		using difference_type = typename std::iterator_traits<iterator_T>::difference_type;
		using pointer = value_type*;

		template<typename arg_iterator_T, typename arg_predicate_F>
		filter_iterator(arg_iterator_T&& ptr, arg_iterator_T&& end_ptr, arg_predicate_F&& f) : ptr(std::forward<arg_iterator_T>(ptr)), end_ptr(std::forward<arg_iterator_T>(end_ptr)), f(std::forward<arg_predicate_F>(f)) {
			if (ptr != end_ptr && !f(*ptr))++* this;
		}

		reference operator*() const {
			return *ptr;
		}
		this_t& operator++() {
			do {
				++ptr;
			} while (ptr != end_ptr && !f(*ptr));
			return *this;
		}
		this_t operator++(int) {
			auto r = *this;
			++* this;
			return r;
		}
		bool operator==(const this_t& rhs) const {
			return ptr == rhs.ptr;
		}
		bool operator!=(const this_t& rhs) const {
			return ptr != rhs.ptr;
		}
		bool operator<(const this_t& rhs) const {
			return ptr < rhs.ptr;
		}
		bool operator<=(const this_t& rhs) const {
			return ptr <= rhs.ptr;
		}
		bool operator>(const this_t& rhs) const {
			return ptr > rhs.ptr;
		}
		bool operator>=(const this_t& rhs) const {
			return ptr >= rhs.ptr;
		}
	};

	template<typename iterator_T, typename predicate_F>
	auto make_filter_iterator(iterator_T&& c, iterator_T&& end, predicate_F&& f) {
		return filter_iterator<iterator_T, predicate_F>(std::forward<iterator_T>(c), std::forward<iterator_T>(end), std::forward<predicate_F>(f));
	}

	template<typename range_T, typename predicate_F>
	auto make_filter_range(range_T&& r, predicate_F&& f) {
		auto begin = make_filter_iterator(r.begin(), r.end(), std::forward<predicate_F>(f));
		return make_iterators_range(begin, make_filter_iterator(r.end(), r.end(), std::forward<predicate_F>(f)));
	}

	template<typename range_T>
	auto ptr(range_T&& r) {
		return make_transform_range(r, [](auto& ref) {
			return &ref;
			});
	}

	template<typename range_T>
	auto reverse(range_T&& r) {
		return make_iterators_range(std::make_reverse_iterator(r.end()), std::make_reverse_iterator(r.begin()));
	}

	template<typename range_T>
	auto range_size(range_T&& r) {
		auto rv = std::distance(r.begin(), r.end());
		return (typename std::make_unsigned<decltype(rv)>::type)rv;
	}

	struct identity {
		template<typename T>
		decltype(auto) operator()(T&& v) const {
			return std::forward<T>(v);
		}
	};

	template<typename iterator_T, typename score_F>
	auto get_best_score(iterator_T begin, iterator_T end, score_F&& score) {
		if (begin == end) return end;
		auto i = begin;
		auto best = i;
		auto best_score = score(*i);
		++i;
		for (; i != end; ++i) {
			auto s = score(*i);
			if (s < best_score) {
				best = i;
				best_score = s;
			}
		}
		return best;
	}

	template<typename cont_T, typename score_F>
	auto get_best_score(cont_T&& cont, score_F&& score) {
		return get_best_score(cont.begin(), cont.end(), std::forward<score_F>(score));
	}

	template<size_t bits>
	using int_fastn_t = typename std::conditional<bits <= 8, std::int_fast8_t,
		typename std::conditional<bits <= 16, int_fast16_t,
		typename std::conditional<bits <= 32, int_fast32_t,
		typename std::enable_if<bits <= 64, int_fast64_t>::type>::type>::type>::type;
	template<size_t bits>
	using uint_fastn_t = typename std::conditional<bits <= 8, std::uint_fast8_t,
		typename std::conditional<bits <= 16, uint_fast16_t,
		typename std::conditional<bits <= 32, uint_fast32_t,
		typename std::enable_if<bits <= 64, uint_fast64_t>::type>::type>::type>::type;

	template<typename T, std::enable_if<std::is_integral<T>::value&& std::numeric_limits<T>::radix == 2>* = nullptr>
	using int_bits = std::integral_constant<size_t, std::numeric_limits<T>::digits + std::is_signed<T>::value>;

	template<typename T>
	using is_native_fast_int = std::integral_constant<bool, std::is_integral<T>::value && sizeof(T) <= sizeof(void*)>;

	template<size_t t_integer_bits, size_t t_fractional_bits, bool t_is_signed, bool t_exact_integer_bits = false>
	struct fixed_point {
		static const bool is_signed = t_is_signed;
		static const bool exact_integer_bits = t_exact_integer_bits;
		static const size_t integer_bits = t_integer_bits;
		static const size_t fractional_bits = t_fractional_bits;
		static const size_t total_bits = integer_bits + fractional_bits;
		using raw_unsigned_type = uint_fastn_t<total_bits>;
		using raw_signed_type = int_fastn_t<total_bits>;
		using raw_type = typename std::conditional<is_signed, raw_signed_type, raw_unsigned_type>::type;
		raw_type raw_value;

		using double_size_fixed_point = fixed_point<total_bits * 2 - fractional_bits, fractional_bits, is_signed>;

		void wrap() {
			if (!exact_integer_bits) return;
			raw_value <<= int_bits<raw_type>::value - total_bits;
			raw_value >>= int_bits<raw_type>::value - total_bits;
		}

		static constexpr fixed_point from_raw(raw_type raw_value) {
			return fixed_point{ exact_integer_bits ? (raw_type)((raw_type)(raw_value << (int_bits<raw_type>::value - total_bits)) >> (int_bits<raw_type>::value - total_bits)) : raw_value };
		}

		template<typename T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
		static fixed_point integer(T integer_value) {
			return from_raw((raw_type)((raw_unsigned_type)integer_value << fractional_bits));
		}

		static fixed_point zero() {
			return integer(0);
		}
		static fixed_point one() {
			return integer(1);
		}

		raw_type integer_part() const {
			return raw_value >> fractional_bits;
		}
		raw_type fractional_part() const {
			return raw_value & (((raw_type)1 << fractional_bits) - 1);
		}

		template<size_t n_integer_bits, size_t n_fractional_bits, bool n_exact_integer_bits, size_t result_integer_bits = integer_bits, size_t result_fractional_bits = fractional_bits, typename std::enable_if<((result_integer_bits < n_integer_bits || result_fractional_bits < n_fractional_bits) && result_fractional_bits <= n_fractional_bits)>::type* = nullptr>
			static auto truncate(const fixed_point<n_integer_bits, n_fractional_bits, is_signed, n_exact_integer_bits>& n) {
				using result_type = fixed_point<result_integer_bits, result_fractional_bits, is_signed, exact_integer_bits>;
				typename result_type::raw_type raw_value = (typename result_type::raw_type)(n.raw_value >> (n_fractional_bits - result_fractional_bits));
				return result_type::from_raw(raw_value);
			}

			template<size_t n_integer_bits, size_t n_fractional_bits, bool n_exact_integer_bits, size_t result_integer_bits = integer_bits, size_t result_fractional_bits = fractional_bits, typename std::enable_if<((result_integer_bits > n_integer_bits || result_fractional_bits > n_fractional_bits) && result_fractional_bits >= n_fractional_bits)>::type* = nullptr>
		static auto extend(const fixed_point<n_integer_bits, n_fractional_bits, is_signed, n_exact_integer_bits>& n) {
			using result_type = fixed_point<result_integer_bits, result_fractional_bits, is_signed, exact_integer_bits>;
			typename result_type::raw_type raw_value = n.raw_value;
			raw_value <<= result_fractional_bits - n_fractional_bits;
			return result_type::from_raw(raw_value);
		}

		fixed_point floor() const {
			return integer(integer_part());
		}
		fixed_point ceil() const {
			return (*this + integer(1) - from_raw(1)).floor();
		}
		fixed_point abs() const {
			if (*this >= zero()) return *this;
			else return from_raw(-raw_value);
		}

		auto as_signed() const {
			return fixed_point<integer_bits, fractional_bits, true, exact_integer_bits>::from_raw(raw_value);
		}
		auto as_unsigned() const {
			return fixed_point<integer_bits, fractional_bits, false, exact_integer_bits>::from_raw(raw_value);
		}

		bool operator==(const fixed_point& n) const {
			return raw_value == n.raw_value;
		}
		bool operator!=(const fixed_point& n) const {
			return raw_value != n.raw_value;
		}
		bool operator<(const fixed_point& n) const {
			return raw_value < n.raw_value;
		}
		bool operator<=(const fixed_point& n) const {
			return raw_value <= n.raw_value;
		}
		bool operator>(const fixed_point& n) const {
			return raw_value > n.raw_value;
		}
		bool operator>=(const fixed_point& n) const {
			return raw_value >= n.raw_value;
		}

		fixed_point operator-() const {
			static_assert(is_signed, "fixed_point: cannot negate an unsigned number");
			return from_raw(-raw_value);
		}

		fixed_point& operator+=(const fixed_point& n) {
			raw_value += n.raw_value;
			wrap();
			return *this;
		}
		fixed_point operator+(const fixed_point& n) const {
			return from_raw(raw_value + n.raw_value);
		}
		fixed_point& operator-=(const fixed_point& n) {
			raw_value -= n.raw_value;
			wrap();
			return *this;
		}
		fixed_point operator-(const fixed_point& n) const {
			return from_raw(raw_value - n.raw_value);
		}

		template<typename T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
		fixed_point& operator/=(T integer_value) {
			static_assert(std::is_signed<T>::value == is_signed, "fixed_point: cannot mix signed/unsigned in division");
			raw_value /= integer_value;
			wrap();
			return *this;
		}
		template<typename T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
		fixed_point operator/(T integer_value) const {
			static_assert(std::is_signed<T>::value == is_signed, "fixed_point: cannot mix signed/unsigned in division");
			return from_raw(raw_value / integer_value);
		}
		template<typename T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
		fixed_point& operator*=(T integer_value) {
			static_assert(std::is_signed<T>::value == is_signed, "fixed_point: cannot mix signed/unsigned in multiplication");
			raw_value *= integer_value;
			wrap();
			return *this;
		}
		template<typename T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
		auto operator*(T integer_value) const {
			static_assert(std::is_signed<T>::value == is_signed, "fixed_point: cannot mix signed/unsigned in multiplication");
			return from_raw(raw_value * integer_value);
		}

		template<size_t n_integer_bits>
		fixed_point& operator*=(const fixed_point<n_integer_bits, fractional_bits, is_signed, exact_integer_bits>& n) {
			return *this = *this * n;
		}

		template<size_t n_integer_bits>
		fixed_point& operator/=(const fixed_point<n_integer_bits, fractional_bits, is_signed, exact_integer_bits>& n) {
			return *this = *this / n;
		}

		// rounds towards negative infinity
		template<size_t n_integer_bits, size_t n_fractional_bits>
		auto operator*(const fixed_point<n_integer_bits, n_fractional_bits, is_signed, exact_integer_bits>& n) {
			using result_type = fixed_point<(integer_bits > n_integer_bits ? integer_bits : n_integer_bits), (fractional_bits > n_fractional_bits ? fractional_bits : n_fractional_bits), is_signed, exact_integer_bits>;
			using tmp_t = typename fixed_point<result_type::integer_bits, fractional_bits + n_fractional_bits, is_signed>::raw_type;
			tmp_t tmp = (tmp_t)raw_value * (tmp_t)n.raw_value >> n_fractional_bits;
			return result_type::from_raw((typename result_type::raw_type)tmp);
		}

		// rounds towards 0
		template<size_t n_integer_bits, size_t n_fractional_bits>
		auto operator/(const fixed_point<n_integer_bits, n_fractional_bits, is_signed, exact_integer_bits>& n) const {
			using result_type = fixed_point<(integer_bits > n_integer_bits ? integer_bits : n_integer_bits), (fractional_bits > n_fractional_bits ? fractional_bits : n_fractional_bits), is_signed, exact_integer_bits>;
			using tmp_t = typename fixed_point<result_type::integer_bits, fractional_bits + n_fractional_bits, is_signed>::raw_type;
			tmp_t tmp = ((tmp_t)raw_value << n_fractional_bits) / (tmp_t)n.raw_value;
			return result_type::from_raw((typename result_type::raw_type)tmp);
		}

		// returns a * b / c
		// rounds towards 0
		static fixed_point multiply_divide(fixed_point a, fixed_point b, fixed_point c) {
			constexpr raw_type max_value_no_overflow = std::numeric_limits<raw_type>::max() >> (int_bits<raw_type>::value / 2);
			using tmp_t = typename fixed_point<integer_bits, fractional_bits + fractional_bits, is_signed>::raw_type;
			if (!is_native_fast_int<tmp_t>::value && a.raw_value <= max_value_no_overflow && b.raw_value <= max_value_no_overflow) {
				return from_raw(a.raw_value * b.raw_value / c.raw_value);
			}
			else {
				return from_raw((tmp_t)a.raw_value * b.raw_value / c.raw_value);
			}
		}

		// returns a / b * c
		// rounds towards 0
		static fixed_point divide_multiply(fixed_point a, fixed_point b, fixed_point c) {
			return from_raw(a.raw_value / b.raw_value * c.raw_value);
		}

	};

	using fp1 = fixed_point<31, 1, true>;
	using fp8 = fixed_point<24, 8, true>;
	using ufp8 = fixed_point<24, 8, false>;
	using fp16 = fixed_point<16, 16, true>;
	using ufp16 = fixed_point<16, 16, false>;
	using direction_t = fixed_point<0, 8, true, true>;

	using xy = xy_t<int>;
	using xy_fp8 = xy_t<fp8>;

	using rect = rect_t<xy>;

	static inline constexpr fp8 operator ""_fp8(unsigned long long int value) {
		return fp8::from_raw((fp8::raw_type)value);
	}

	static inline constexpr direction_t operator ""_dir(unsigned long long int value) {
		return direction_t::from_raw((direction_t::raw_type)value);
	}

	template<typename T, typename index_T, size_t N = (size_t)index_T::None>
	struct type_indexed_array {
	private:
		using arr_T = std::array<T, N>;
		arr_T arr;
	public:
		using value_type = T;
		using size_type = std::size_t;
		using difference_type = std::ptrdiff_t;
		using reference = value_type&;
		using const_reference = const value_type&;
		using pointer = value_type*;
		using const_pointer = const value_type*;
		using iterator = typename arr_T::iterator;
		using const_iterator = typename arr_T::const_iterator;
		using reverse_iterator = typename arr_T::reverse_iterator;
		using const_reverse_iterator = typename arr_T::const_reverse_iterator;

		reference at(index_T pos) {
			return arr.at((size_t)pos);
		}
		const_reference at(index_T pos) const {
			return arr.at((size_t)pos);
		}
		reference operator[](index_T pos) {
			return arr[(size_t)pos];
		}
		const_reference operator[](index_T pos) const {
			return arr[(size_t)pos];
		}
		reference front() {
			return arr.front();
		}
		const_reference front() const {
			return arr.front();
		}
		reference back() {
			return arr.back();
		}
		const_reference back() const {
			return arr.back();
		}
		pointer data() noexcept {
			return arr.data();
		}
		const_pointer data() const noexcept {
			return arr.data();
		}
		iterator begin() noexcept {
			return arr.begin();
		}
		const_iterator begin() const noexcept {
			return arr.begin();
		}
		const_iterator cbegin() const noexcept {
			return arr.cbegin();
		}
		iterator end() noexcept {
			return arr.end();
		}
		const_iterator end() const noexcept {
			return arr.end();
		}
		const_iterator cend() const noexcept {
			return arr.cend();
		}
		bool empty() const noexcept {
			return arr.empty();
		}
		constexpr size_type size() const noexcept {
			return arr.size();
		}
		constexpr size_type max_size() const noexcept {
			return arr.max_size();
		}
		void fill(const_reference value) {
			arr.fill(value);
		}
		void swap(type_indexed_array& n) {
			arr.swap(n.arr);
		}
	};

	template<typename T, typename std::enable_if<std::is_unsigned<T>::value>::type* = nullptr>
	T isqrt(T n) {
		T r = 0;
		T p = (T)1 << (8 * sizeof(T) - 2);
		while (p > n) p /= 4u;
		while (p) {
			if (n >= r + p) {
				n -= r + p;
				r += 2u * p;
			}
			r /= 2u;
			p /= 4u;
		}
		return r;
	}
}


namespace bwgame {

	struct unit_type_t;
	struct weapon_type_t;
	struct upgrade_type_t;
	struct tech_type_t;
	struct flingy_type_t;
	struct sprite_type_t;
	struct image_type_t;
	struct order_type_t;


	template<typename T>
	struct type_container {
		std::vector<T> vec;
		type_container() = default;
		type_container(const type_container&) = delete;
		type_container(type_container&&) = default;
		type_container& operator=(const type_container&) = delete;
		type_container& operator=(type_container&&) = default;
	};

	template<typename T>
	struct id_type_for;
	template<> struct id_type_for<flingy_type_t> { using type = FlingyTypes; };
	template<> struct id_type_for<unit_type_t> { using type = UnitTypes; };
	template<> struct id_type_for<weapon_type_t> { using type = WeaponTypes; };
	template<> struct id_type_for<upgrade_type_t> { using type = UpgradeTypes; };
	template<> struct id_type_for<tech_type_t> { using type = TechTypes; };
	template<> struct id_type_for<sprite_type_t> { using type = SpriteTypes; };
	template<> struct id_type_for<image_type_t> { using type = ImageTypes; };
	template<> struct id_type_for<order_type_t> { using type = Orders; };
	template<typename T>
	using id_type_for_t = typename id_type_for<typename std::remove_const<T>::type>::type;

	template<typename T>
	struct type_id {
	private:
		using id_T = id_type_for_t<T>;
		id_T id;
		T* pointer;
	public:
		type_id() = default;
		type_id(T* pointer) : id(pointer ? pointer->id : id_T::None), pointer(pointer) {}
		type_id(id_T id) : id(id), pointer(nullptr) {}
		T* operator->() {
			return pointer;
		}
		const T* operator->() const {
			return pointer;
		}
		T& operator*() {
			return *pointer;
		}
		const T& operator*() const {
			return *pointer;
		}
		explicit operator bool() const {
			return pointer != nullptr;
		}
		operator T* () {
			return pointer;
		}
		operator const T* () const {
			return pointer;
		}
		operator id_T() const {
			return id;
		}
	};

	struct unit_type_t {
		enum flags_t : uint32_t {
			flag_building = 1,
			flag_addon = 2,
			flag_flyer = 4,

			flag_worker = 8,
			flag_turret = 0x10,
			flag_flying_building = 0x20,
			flag_hero = 0x40,
			flag_regens_hp = 0x80,
			flag_100 = 0x100,

			flag_two_units_in_one_egg = 0x400,
			flag_powerup = 0x800,
			flag_resource_depot = 0x1000,
			flag_resource = 0x2000,
			flag_robotic = 0x4000,
			flag_detector = 0x8000,
			flag_organic = 0x10000,
			flag_requires_creep = 0x20000,

			flag_can_burrow = 0x100000,
			flag_has_energy = 0x200000,
			flag_initially_cloaked = 0x400000,
			flag_sprite_size_medium = 0x2000000,
			flag_sprite_size_large = 0x4000000,
			flag_can_move = 0x8000000,
			flag_can_turn = 0x10000000,
			flag_invincible = 0x20000000,
			flag_mechanical = 0x40000000,
			flag_80000000 = 0x80000000,
		};

		UnitTypes id;

		type_id<const flingy_type_t> flingy;
		type_id<unit_type_t> turret_unit_type;
		type_id<unit_type_t> subunit2;
		type_id<unit_type_t> infestation_unit;
		type_id<const image_type_t> construction_animation;
		int unit_direction;
		bool has_shield;
		int shield_points;
		fp8 hitpoints;
		int elevation_level;
		int unknown1;
		type_id<const order_type_t> computer_ai_idle;
		type_id<const order_type_t> human_ai_idle;
		type_id<const order_type_t> return_to_idle;
		type_id<const order_type_t> attack_unit;
		type_id<const order_type_t> attack_move;
		type_id<const weapon_type_t> ground_weapon;
		int max_ground_hits;
		type_id<const weapon_type_t> air_weapon;
		int max_air_hits;
		flags_t flags;
		int target_acquisition_range;
		int sight_range;
		type_id<upgrade_type_t> armor_upgrade;
		int unit_size;
		int armor;
		size_t right_click_action;
		xy placement_size;
		xy addon_position;
		rect dimensions;
		int mineral_cost;
		int gas_cost;
		int build_time;
		int group_flags;
		fp1 supply_provided;
		fp1 supply_required;
		size_t space_required;
		size_t space_provided;
		bool is_broodwar;
	};

	using unit_types_t = type_container<unit_type_t>;

	struct weapon_type_t {
		enum {
			bullet_type_fly,
			bullet_type_follow_target,
			bullet_type_appear_at_target_unit,
			bullet_type_persist_at_target_pos,
			bullet_type_appear_at_target_pos,
			bullet_type_appear_at_source_unit,
			bullet_type_self_destruct,
			bullet_type_bounce,
			bullet_type_attack_target_pos,
			bullet_type_extend_to_max_range
		};
		enum {
			hit_type_none,
			hit_type_normal,
			hit_type_radial_splash,
			hit_type_enemy_splash,
			hit_type_lockdown,
			hit_type_nuclear_missile,
			hit_type_parasite,
			hit_type_broodlings,
			hit_type_emp_shockwave,
			hit_type_irradiate,
			hit_type_ensnare,
			hit_type_plague,
			hit_type_stasis_field,
			hit_type_dark_swarm,
			hit_type_consume,
			hit_type_yamato_gun,
			hit_type_restoration,
			hit_type_disruption_web,
			hit_type_corrosive_acid,
			hit_type_mind_control,
			hit_type_feedback,
			hit_type_optical_flare,
			hit_type_maelstrom,
			hit_type_23,
			hit_type_air_splash
		};
		enum {
			damage_type_none,
			damage_type_explosive,
			damage_type_concussive,
			damage_type_normal,
			damage_type_ignore_armor
		};

		WeaponTypes id;

		type_id<const flingy_type_t> flingy;
		int target_flags;
		int min_range;
		int max_range;
		type_id<upgrade_type_t> damage_upgrade;
		int damage_type;
		int bullet_type;
		int lifetime;
		int hit_type;
		int inner_splash_radius;
		int medium_splash_radius;
		int outer_splash_radius;
		int damage_amount;
		int damage_bonus;
		int cooldown;
		int bullet_count;
		fp8 attack_angle;
		direction_t bullet_heading_offset;
		int forward_offset;
		int upward_offset;
	};

	using weapon_types_t = type_container<weapon_type_t>;

	struct upgrade_type_t {
		UpgradeTypes id;

		int mineral_cost_base;
		int mineral_cost_factor;
		int gas_cost_base;
		int gas_cost_factor;
		int time_cost_base;
		int time_cost_factor;
		int race;
		int max_level;
		bool is_broodwar;
	};

	using upgrade_types_t = type_container<upgrade_type_t>;

	struct tech_type_t {
		TechTypes id;

		int mineral_cost;
		int gas_cost;
		int research_time;
		int energy_cost;
		int race;
		int flags;
	};

	using tech_types_t = type_container<tech_type_t>;

	struct flingy_type_t {
		FlingyTypes id;

		type_id<sprite_type_t> sprite;
		fp8 top_speed;
		fp8 acceleration;
		fp8 halt_distance;
		fp8 turn_rate;
		int movement_type;
	};

	using flingy_types_t = type_container<flingy_type_t>;

	struct sprite_type_t {
		SpriteTypes id;

		type_id<image_type_t> image;
		int health_bar_size;
		bool visible;
	};

	using sprite_types_t = type_container<sprite_type_t>;

	struct image_type_t {
		ImageTypes id;

		bool has_directional_frames;
		bool is_clickable;
		bool has_iscript_animations;
		bool always_visible;
		int modifier;
		int color_shift;
		int iscript_id;
		int shield_filename_index;
		int attack_filename_index;
		int damage_filename_index;
		int special_filename_index;
		int landing_dust_filename_index;
		int lift_off_filename_index;
	};

	using image_types_t = type_container<image_type_t>;

	struct order_type_t {
		Orders id;

		bool targets_enemies;
		int background;
		bool valid_for_turret;
		bool can_be_interrupted;
		bool unk7;
		bool can_be_queued;
		int unk9;
		bool can_be_obstructed;
		int unk11;
		WeaponTypes weapon;    // weapon and tech_type could be pointers, but then order_types would 
		TechTypes tech_type;   // need to live in game_state
		int animation;
		int highlight;
		Orders target_order;
	};

	using order_types_t = type_container<order_type_t>;

	namespace iscript_anims {
		enum {
			Init,
			Death,
			GndAttkInit,
			AirAttkInit,
			Unused1,
			GndAttkRpt,
			AirAttkRpt,
			CastSpell,
			GndAttkToIdle,
			AirAttkToIdle,
			Unused2,
			Walking,
			WalkingToIdle,
			SpecialState1,
			SpecialState2,
			AlmostBuilt,
			Built,
			Landing,
			LiftOff,
			IsWorking,
			WorkingToIdle,
			WarpIn,
			Unused3,
			StarEditInit,
			Disable,
			Burrow,
			UnBurrow,
			Enable,
			MAX
		};
	}

}
namespace bwgame {

	struct sprite_t;
	struct flingy_t;
	struct unit_t;

	template<typename T>
	struct unit_id_t {
		T raw_value = 0;
		unit_id_t() = default;
		explicit unit_id_t(T raw_value) : raw_value(raw_value) {}
		explicit unit_id_t(size_t index, unsigned int generation) : raw_value((T)(index | generation << 11)) {}
		bool operator==(const unit_id_t& n) const {
			return raw_value == n.raw_value;
		}
		size_t index() const {
			return raw_value & 0x7ff;
		}
		unsigned int generation() const {
			return raw_value >> 11;
		}
	};

	using unit_id = unit_id_t<uint16_t>;
	using unit_id_32 = unit_id_t<uint32_t>;

	struct default_link_f {
		template<typename T>
		auto* operator()(T* ptr) {
			return (std::pair<T*, T*>*) & ptr->link;
		}
	};

	template<typename cont_T, typename T>
	static void bw_insert_list(cont_T& cont, T& v) {
		if (cont.empty()) cont.push_front(v);
		else cont.insert(std::next(cont.begin()), v);
	}

	template<typename T, size_t max_size, size_t allocation_granularity>
	struct object_container {
		std::deque<std::array<T, allocation_granularity>> list;
		intrusive_list<T, default_link_f> free_list;
		size_t size = 0;

		T* get(size_t index, bool add_new_to_free = true) {
			if (index) index = max_size - index;
			while (size <= index) grow(add_new_to_free);
			return &list[index / allocation_granularity][index % allocation_granularity];
		}

		T* try_get(size_t index) {
			if (index) index = max_size - index;
			if (size <= index) return nullptr;
			return &list[index / allocation_granularity][index % allocation_granularity];
		}

		T* at(size_t index) {
			if (index) index = max_size - index;
			return &list[index / allocation_granularity][index % allocation_granularity];
		}

		const T* at(size_t index) const {
			if (index) index = max_size - index;
			return &list[index / allocation_granularity][index % allocation_granularity];
		}

		void grow(bool add_new_to_free) {
			list.emplace_back();
			size_t n = std::min(allocation_granularity, max_size - size);
			for (size_t i = 0; i != n; ++i) {
				T* obj = &list.back()[i];
				obj->index = size == 0 ? 0 : max_size - size;
				if (add_new_to_free) free_list.push_back(*obj);
				++size;
			}
		}

		T* top() {
			if (free_list.empty()) {
				if (size == max_size) return nullptr;
				grow(true);
			}
			else if (size != max_size && std::next(free_list.begin()) == free_list.end()) {
				grow(true);
			}
			auto* r = &free_list.front();
			return r;
		}
		void pop() {
			free_list.pop_front();
		}
		void push(T* obj) {
			bw_insert_list(free_list, *obj);
		}
	};

	enum struct race_t {
		zerg,
		terran,
		protoss,
		none
	};

	struct cv5_entry {
		uint16_t flags;
		std::array<uint16_t, 16> mega_tile_index;
	};
	struct vf4_entry {
		enum flags_t : uint16_t {
			flag_walkable = 1,
			flag_middle = 2,
			flag_high = 4,
			flag_very_high = 8
		};

		std::array<uint16_t, 16> flags;
	};

	struct tile_t {
		enum {
			flag_walkable = 1,
			flag_unk0 = 2,
			flag_unwalkable = 4,
			flag_unk1 = 8,
			flag_provides_cover = 0x10,
			flag_unk3 = 0x20,
			flag_has_creep = 0x40,
			flag_unbuildable = 0x80,
			flag_very_high = 0x100,
			flag_middle = 0x200,
			flag_high = 0x400,
			flag_occupied = 0x800,
			flag_creep_receding = 0x1000,
			flag_partially_walkable = 0x2000,
			flag_temporary_creep = 0x4000,
			flag_unk4 = 0x8000
		};
		uint8_t visible;
		uint8_t explored;
		uint16_t flags;
	};

	struct target_t {
		xy pos;
		unit_t* unit = nullptr;
	};

	struct link_base {
		std::pair<link_base*, link_base*> link;
	};

	struct image_t : link_base {

		enum flags_t : uint_fast32_t {
			flag_redraw = 1,
			flag_horizontally_flipped = 2,
			flag_y_frozen = 4,
			flag_has_directional_frames = 8,
			flag_has_iscript_animations = 0x10,
			flag_clickable = 0x20,
			flag_hidden = 0x40,
			flag_uses_special_offset = 0x80
		};

		size_t index;
		const image_type_t* image_type;
		int modifier;
		size_t frame_index_offset;
		int flags;
		xy offset;
		size_t frame_index_base;
		size_t frame_index;
		int modifier_data1;
		int modifier_data2;
		sprite_t* sprite;
		int frozen_y_value;

	};

	struct sprite_t : link_base {

		enum flags_t : uint_fast32_t {
			flag_selected = 0x8,
			flag_turret = 0x10,
			flag_hidden = 0x20,
			flag_burrowed = 0x40,
			flag_iscript_nobrk = 0x80,
		};

		size_t index;
		const sprite_type_t* sprite_type;
		int owner;
		int visibility_flags;
		int elevation_level;
		int flags;
		size_t width;
		size_t height;
		xy position;
		image_t* main_image;
		intrusive_list<image_t, default_link_f> images;

	};

	struct thingy_t : link_base {
		fp8 hp;
		sprite_t* sprite;
	};

	struct flingy_t : thingy_t {

		size_t index;
		target_t move_target;
		xy next_movement_waypoint;
		xy next_target_waypoint;
		int movement_flags;
		direction_t heading;
		fp8 flingy_turn_rate;
		direction_t next_velocity_direction;
		const flingy_type_t* flingy_type;
		int flingy_movement_type;
		xy position;
		xy_fp8 exact_position;
		fp8 flingy_top_speed;
		fp8 current_speed;
		fp8 next_speed;
		xy_fp8 velocity;
		fp8 flingy_acceleration;
		direction_t current_velocity_direction;
		direction_t desired_velocity_direction;
		int order_signal;

	};

	struct bullet_t : flingy_t {
		enum {
			state_init,
			state_move,
			state_follow,
			state_bounce,
			state_damage_over_time,
			state_dying,
			state_hit_near_target
		};
		size_t index;
		int bullet_state;
		unit_t* bullet_target;
		xy bullet_target_pos;
		const weapon_type_t* weapon_type;
		int remaining_time;
		int hit_flags;
		int remaining_bounces;
		int owner;
		unit_t* bullet_owner_unit;
		unit_t* prev_bounce_unit;
		size_t hit_near_target_position_index;
	};

	struct order_target_t {
		xy position;
		unit_t* unit = nullptr;
		const unit_type_t* unit_type = nullptr;
		order_target_t() = default;
		order_target_t(unit_t* unit) : unit(unit) {}
		order_target_t(xy position, unit_t* unit) : position(position), unit(unit) {}
		order_target_t(xy position) : position(position) {}
	};

	struct order_t : link_base {
		size_t index;
		const order_type_t* order_type;
		order_target_t target;
	};

	struct path_t : link_base {

		int delay = 0;
		int creation_frame = 0;
		int state_flags = 0;

		std::deque<xy> short_path;

		size_t current_short_path_index = 0;

		xy source;
		xy destination;
		xy next;

		unit_id last_collision_unit;
		fp8 last_collision_speed;
		direction_t slide_free_direction;

	};

	struct unit_t : flingy_t {

		unit_t() {}

		enum status_flags_t : uint_fast32_t {
			status_flag_completed = 1,
			status_flag_grounded_building = 2,
			status_flag_flying = 4,
			status_flag_8 = 8,
			status_flag_burrowed = 0x10,
			status_flag_in_bunker = 0x20,
			status_flag_loaded = 0x40,

			status_flag_requires_detector = 0x100,
			status_flag_cloaked = 0x200,
			status_flag_disabled = 0x400,
			status_flag_passively_cloaked = 0x800,
			status_flag_order_not_interruptible = 0x1000,
			status_flag_iscript_nobrk = 0x2000,
			status_flag_4000 = 0x4000,
			status_flag_cannot_attack = 0x8000,
			status_flag_can_turn = 0x10000,
			status_flag_can_move = 0x20000,
			status_flag_collision = 0x40000,
			status_flag_immovable = 0x80000,
			status_flag_ground_unit = 0x100000,
			status_flag_no_collide = 0x200000,
			status_flag_400000 = 0x400000,
			status_flag_gathering = 0x800000,
			status_flag_turret_walking = 0x1000000,

			status_flag_invincible = 0x4000000,
			status_flag_ready_to_attack = 0x8000000,

			status_flag_speed_upgrade = 0x10000000,
			status_flag_cooldown_upgrade = 0x20000000,
			status_flag_hallucination = 0x40000000,
			status_flag_lifetime_expired = 0x80000000,
		};

		int owner;
		const order_type_t* order_type;
		int order_state;
		const unit_type_t* order_unit_type;
		int main_order_timer;
		int ground_weapon_cooldown;
		int air_weapon_cooldown;
		int spell_cooldown;
		target_t order_target;

		fp8 shield_points;
		const unit_type_t* unit_type;

		std::pair<unit_t*, unit_t*> player_units_link;

		unit_t* subunit;
		intrusive_list<order_t, default_link_f> order_queue;
		unit_t* auto_target_unit;
		unit_t* connected_unit;
		int order_queue_count;
		int order_process_timer;
		const unit_type_t* previous_unit_type;
		int last_attacking_player;
		int secondary_order_timer;
		int movement_state;
		std::deque<const unit_type_t*> build_queue;
		fp8 energy;
		unsigned int unit_id_generation;
		const order_type_t* secondary_order_type;
		int damage_overlay_state;
		fp8 hp_construction_rate;
		int remaining_build_time;
		int previous_hp;
		std::array<unit_id, 8> loaded_units;

		struct fighter_link {
			auto* operator()(unit_t* ptr) {
				return &ptr->fighter.fighter_link;
			}
			auto* operator()(const unit_t* ptr) {
				return &ptr->fighter.fighter_link;
			}
		};
		union {
			struct {
				size_t spider_mine_count;
			} vulture;
			struct {
				unit_t* parent;
				std::pair<unit_t*, unit_t*> fighter_link;
				bool is_outside;
			} fighter;
			struct {
				intrusive_list<unit_t, fighter_link> inside_units;
				intrusive_list<unit_t, fighter_link> outside_units;
				size_t inside_count;
				size_t outside_count;
			} carrier, reaver;
			struct {
				thingy_t* nuke_dot;
			} ghost;
		};

		struct {
			unit_t* powerup;
			xy target_resource_position;
			unit_t* target_resource_unit;
			int repair_timer;
			bool is_gathering;
			int resources_carried;
			unit_t* gather_target;
			std::pair<unit_t*, unit_t*> gather_link;
		} worker;
		struct worker_gather_link {
			auto* operator()(unit_t* ptr) {
				return &ptr->worker.gather_link;
			}
			auto* operator()(const unit_t* ptr) {
				return &ptr->worker.gather_link;
			}
		};

		struct building_t {
			building_t() {}

			unit_t* addon;
			const unit_type_t* addon_build_type;
			int upgrade_research_time;
			const tech_type_t* researching_type;
			const upgrade_type_t* upgrading_type;
			int larva_timer;
			bool is_landing;
			int creep_timer;
			int upgrading_level;
			union {
				struct {
					int resource_count;
					int resource_iscript;
					bool is_being_gathered;
					intrusive_list<unit_t, worker_gather_link> gather_queue;
				} resource;
				struct {
					unit_t* exit;
				} nydus;
				struct {
					unit_t* nuke;
					bool ready;
				} silo;
				struct {
					xy origin;
				} powerup;
				struct {
					std::array<int, 4> larva_spawn_side_values;
				} hatchery;
			};
		} building;

		int status_flags;
		int carrying_flags;
		int secondary_order_state;
		int move_target_timer;
		uint32_t detected_flags;
		unit_t* current_build_unit;
		std::pair<unit_t*, unit_t*> cloaked_unit_link;

		path_t* path;
		int pathing_collision_counter;
		int pathing_flags;
		bool is_being_healed;
		rect terrain_no_collision_bounds;

		int remove_timer;
		fp8 defensive_matrix_hp;
		int defensive_matrix_timer;
		int stim_timer;
		int ensnare_timer;
		int lockdown_timer;
		int irradiate_timer;
		int stasis_timer;
		int plague_timer;
		int storm_timer;
		unit_t* irradiated_by;
		int irradiate_owner;
		int parasite_flags;
		int cycle_counter;
		int blinded_by;
		int maelstrom_timer;
		int acid_spore_count;
		std::array<int, 9> acid_spore_time;

		int next_hit_near_target_position_index;
		int repulse_flags;
		direction_t repulse_direction;
		size_t repulse_index;

		rect unit_finder_bounding_box;
	};

}


namespace bwgame {

	struct global_state {

		global_state() = default;
		global_state(global_state&) = delete;
		global_state(global_state&&) = delete;
		global_state& operator=(global_state&) = delete;
		global_state& operator=(global_state&&) = delete;

		flingy_types_t flingy_types;
		sprite_types_t sprite_types;
		image_types_t image_types;
		order_types_t order_types;

		std::vector<uint8_t> units_dat;
		std::vector<uint8_t> weapons_dat;
		std::vector<uint8_t> upgrades_dat;
		std::vector<uint8_t> techdata_dat;

		std::array<std::vector<uint8_t>, 8> tileset_vf4;
		std::array<std::vector<uint8_t>, 8> tileset_cv5;

		std::array<std::vector<cv5_entry>, 8> cv5;
		std::array<std::vector<vf4_entry>, 8> vf4;
		std::array<std::vector<uint16_t>, 8>  mega_tile_flags;

		std::vector<cv5_entry>& get_cv5(int tileset) {
			return cv5[tileset];
		}

		std::vector<vf4_entry>& get_vf4(int tileset) {
			return vf4[tileset];
		}

		std::vector<uint16_t>& get_mega_tile_flags(int tileset) {
			if (mega_tile_flags.at(tileset).empty()) {
				auto& vf4 = get_vf4(tileset);
				mega_tile_flags[tileset].resize(vf4.size());
				for (size_t i = 0; i < mega_tile_flags[tileset].size(); ++i) {
					int flags = 0;
					auto& mt = vf4[i];
					int walkable_count = 0;
					int middle_count = 0;
					int high_count = 0;
					int very_high_count = 0;
					for (size_t y = 0; y < 4; ++y) {
						for (size_t x = 0; x < 4; ++x) {
							if (mt.flags[y * 4 + x] & vf4_entry::flag_walkable) ++walkable_count;
							if (mt.flags[y * 4 + x] & vf4_entry::flag_middle) ++middle_count;
							if (mt.flags[y * 4 + x] & vf4_entry::flag_high) ++high_count;
							if (mt.flags[y * 4 + x] & vf4_entry::flag_very_high) ++very_high_count;
						}
					}
					if (walkable_count > 12) flags |= tile_t::flag_walkable;
					else flags |= tile_t::flag_unwalkable;
					if (walkable_count && walkable_count != 0x10) flags |= tile_t::flag_partially_walkable;
					if (high_count < 12 && middle_count + high_count >= 12) flags |= tile_t::flag_middle;
					if (high_count >= 12) flags |= tile_t::flag_high;
					if (very_high_count) flags |= tile_t::flag_very_high;
					mega_tile_flags[tileset][i] = flags;
				}
			}
			return mega_tile_flags[tileset];
		}
	};

	extern global_state global_st;
}

namespace bwgame {

	static const std::array<unsigned int, 64> tan_table = {
		7, 13, 19, 26, 32, 38, 45, 51, 58, 65, 71, 78, 85, 92,
		99, 107, 114, 122, 129, 137, 146, 154, 163, 172, 181,
		190, 200, 211, 221, 233, 244, 256, 269, 283, 297, 312,
		329, 346, 364, 384, 405, 428, 452, 479, 509, 542, 578,
		619, 664, 716, 775, 844, 926, 1023, 1141, 1287, 1476,
		1726, 2076, 2600, 3471, 5211, 10429, std::numeric_limits<unsigned int>::max()
	};

	static const std::array<int, 16 * 2> repulse_adjust_table = {
		-5, -5, -5, 5, 5, -5, 5, 5, 5, -5, 5, 5, -5, -5, -5, 5, -5, 5, 5, -5, -5, -5, 5, 5, -5, 5, 5, -5, 5, 5, -5, -5
	};

	static const xy_fp8 direction_table[256] = {
		{0_fp8,-256_fp8},{6_fp8,-256_fp8},{13_fp8,-256_fp8},{19_fp8,-255_fp8},{25_fp8,-255_fp8},{31_fp8,-254_fp8},{38_fp8,-253_fp8},{44_fp8,-252_fp8},
		{50_fp8,-251_fp8},{56_fp8,-250_fp8},{62_fp8,-248_fp8},{68_fp8,-247_fp8},{74_fp8,-245_fp8},{80_fp8,-243_fp8},{86_fp8,-241_fp8},{92_fp8,-239_fp8},
		{98_fp8,-237_fp8},{104_fp8,-234_fp8},{109_fp8,-231_fp8},{115_fp8,-229_fp8},{121_fp8,-226_fp8},{126_fp8,-223_fp8},{132_fp8,-220_fp8},{137_fp8,-216_fp8},
		{142_fp8,-213_fp8},{147_fp8,-209_fp8},{152_fp8,-206_fp8},{157_fp8,-202_fp8},{162_fp8,-198_fp8},{167_fp8,-194_fp8},{172_fp8,-190_fp8},{177_fp8,-185_fp8},
		{181_fp8,-181_fp8},{185_fp8,-177_fp8},{190_fp8,-172_fp8},{194_fp8,-167_fp8},{198_fp8,-162_fp8},{202_fp8,-157_fp8},{206_fp8,-152_fp8},{209_fp8,-147_fp8},
		{213_fp8,-142_fp8},{216_fp8,-137_fp8},{220_fp8,-132_fp8},{223_fp8,-126_fp8},{226_fp8,-121_fp8},{229_fp8,-115_fp8},{231_fp8,-109_fp8},{234_fp8,-104_fp8},
		{237_fp8,-98_fp8},{239_fp8,-92_fp8},{241_fp8,-86_fp8},{243_fp8,-80_fp8},{245_fp8,-74_fp8},{247_fp8,-68_fp8},{248_fp8,-62_fp8},{250_fp8,-56_fp8},
		{251_fp8,-50_fp8},{252_fp8,-44_fp8},{253_fp8,-38_fp8},{254_fp8,-31_fp8},{255_fp8,-25_fp8},{255_fp8,-19_fp8},{256_fp8,-13_fp8},{256_fp8,-6_fp8},
		{256_fp8,0_fp8},{256_fp8,6_fp8},{256_fp8,13_fp8},{255_fp8,19_fp8},{255_fp8,25_fp8},{254_fp8,31_fp8},{253_fp8,38_fp8},{252_fp8,44_fp8},
		{251_fp8,50_fp8},{250_fp8,56_fp8},{248_fp8,62_fp8},{247_fp8,68_fp8},{245_fp8,74_fp8},{243_fp8,80_fp8},{241_fp8,86_fp8},{239_fp8,92_fp8},
		{237_fp8,98_fp8},{234_fp8,104_fp8},{231_fp8,109_fp8},{229_fp8,115_fp8},{226_fp8,121_fp8},{223_fp8,126_fp8},{220_fp8,132_fp8},{216_fp8,137_fp8},
		{213_fp8,142_fp8},{209_fp8,147_fp8},{206_fp8,152_fp8},{202_fp8,157_fp8},{198_fp8,162_fp8},{194_fp8,167_fp8},{190_fp8,172_fp8},{185_fp8,177_fp8},
		{181_fp8,181_fp8},{177_fp8,185_fp8},{172_fp8,190_fp8},{167_fp8,194_fp8},{162_fp8,198_fp8},{157_fp8,202_fp8},{152_fp8,206_fp8},{147_fp8,209_fp8},
		{142_fp8,213_fp8},{137_fp8,216_fp8},{132_fp8,220_fp8},{126_fp8,223_fp8},{121_fp8,226_fp8},{115_fp8,229_fp8},{109_fp8,231_fp8},{104_fp8,234_fp8},
		{98_fp8,237_fp8},{92_fp8,239_fp8},{86_fp8,241_fp8},{80_fp8,243_fp8},{74_fp8,245_fp8},{68_fp8,247_fp8},{62_fp8,248_fp8},{56_fp8,250_fp8},
		{50_fp8,251_fp8},{44_fp8,252_fp8},{38_fp8,253_fp8},{31_fp8,254_fp8},{25_fp8,255_fp8},{19_fp8,255_fp8},{13_fp8,256_fp8},{6_fp8,256_fp8},
		{0_fp8,256_fp8},{-6_fp8,256_fp8},{-13_fp8,256_fp8},{-19_fp8,255_fp8},{-25_fp8,255_fp8},{-31_fp8,254_fp8},{-38_fp8,253_fp8},{-44_fp8,252_fp8},
		{-50_fp8,251_fp8},{-56_fp8,250_fp8},{-62_fp8,248_fp8},{-68_fp8,247_fp8},{-74_fp8,245_fp8},{-80_fp8,243_fp8},{-86_fp8,241_fp8},{-92_fp8,239_fp8},
		{-98_fp8,237_fp8},{-104_fp8,234_fp8},{-109_fp8,231_fp8},{-115_fp8,229_fp8},{-121_fp8,226_fp8},{-126_fp8,223_fp8},{-132_fp8,220_fp8},{-137_fp8,216_fp8},
		{-142_fp8,213_fp8},{-147_fp8,209_fp8},{-152_fp8,206_fp8},{-157_fp8,202_fp8},{-162_fp8,198_fp8},{-167_fp8,194_fp8},{-172_fp8,190_fp8},{-177_fp8,185_fp8},
		{-181_fp8,181_fp8},{-185_fp8,177_fp8},{-190_fp8,172_fp8},{-194_fp8,167_fp8},{-198_fp8,162_fp8},{-202_fp8,157_fp8},{-206_fp8,152_fp8},{-209_fp8,147_fp8},
		{-213_fp8,142_fp8},{-216_fp8,137_fp8},{-220_fp8,132_fp8},{-223_fp8,126_fp8},{-226_fp8,121_fp8},{-229_fp8,115_fp8},{-231_fp8,109_fp8},{-234_fp8,104_fp8},
		{-237_fp8,98_fp8},{-239_fp8,92_fp8},{-241_fp8,86_fp8},{-243_fp8,80_fp8},{-245_fp8,74_fp8},{-247_fp8,68_fp8},{-248_fp8,62_fp8},{-250_fp8,56_fp8},
		{-251_fp8,50_fp8},{-252_fp8,44_fp8},{-253_fp8,38_fp8},{-254_fp8,31_fp8},{-255_fp8,25_fp8},{-255_fp8,19_fp8},{-256_fp8,13_fp8},{-256_fp8,6_fp8},
		{-256_fp8,0_fp8},{-256_fp8,-6_fp8},{-256_fp8,-13_fp8},{-255_fp8,-19_fp8},{-255_fp8,-25_fp8},{-254_fp8,-31_fp8},{-253_fp8,-38_fp8},{-252_fp8,-44_fp8},
		{-251_fp8,-50_fp8},{-250_fp8,-56_fp8},{-248_fp8,-62_fp8},{-247_fp8,-68_fp8},{-245_fp8,-74_fp8},{-243_fp8,-80_fp8},{-241_fp8,-86_fp8},{-239_fp8,-92_fp8},
		{-237_fp8,-98_fp8},{-234_fp8,-104_fp8},{-231_fp8,-109_fp8},{-229_fp8,-115_fp8},{-226_fp8,-121_fp8},{-223_fp8,-126_fp8},{-220_fp8,-132_fp8},{-216_fp8,-137_fp8},
		{-213_fp8,-142_fp8},{-209_fp8,-147_fp8},{-206_fp8,-152_fp8},{-202_fp8,-157_fp8},{-198_fp8,-162_fp8},{-194_fp8,-167_fp8},{-190_fp8,-172_fp8},{-185_fp8,-177_fp8},
		{-181_fp8,-181_fp8},{-177_fp8,-185_fp8},{-172_fp8,-190_fp8},{-167_fp8,-194_fp8},{-162_fp8,-198_fp8},{-157_fp8,-202_fp8},{-152_fp8,-206_fp8},{-147_fp8,-209_fp8},
		{-142_fp8,-213_fp8},{-137_fp8,-216_fp8},{-132_fp8,-220_fp8},{-126_fp8,-223_fp8},{-121_fp8,-226_fp8},{-115_fp8,-229_fp8},{-109_fp8,-231_fp8},{-104_fp8,-234_fp8},
		{-98_fp8,-237_fp8},{-92_fp8,-239_fp8},{-86_fp8,-241_fp8},{-80_fp8,-243_fp8},{-74_fp8,-245_fp8},{-68_fp8,-247_fp8},{-62_fp8,-248_fp8},{-56_fp8,-250_fp8},
		{-50_fp8,-251_fp8},{-44_fp8,-252_fp8},{-38_fp8,-253_fp8},{-31_fp8,-254_fp8},{-25_fp8,-255_fp8},{-19_fp8,-255_fp8},{-13_fp8,-256_fp8},{-6_fp8,-256_fp8}
	};

	global_state global_st;

	template<typename T>
	struct autocast {
		T val;
		operator T() {
			return val;
		}
		T operator->() {
			return val;
		}
		autocast(T val) : val(val) {}
		template<typename T2, typename std::enable_if<std::is_same<typename std::decay<T2>::type, unit_t>::value>::type* = nullptr>
		autocast(T2* ptr) : val(ptr->unit_type) {}
		template<typename T2>
		autocast(type_id<T2> ptr) : val(ptr) {}
	};

	using unit_type_autocast = autocast<const unit_type_t*>;

	struct game_state {

		game_state() = default;
		game_state(const game_state&) = delete;
		game_state(game_state&&) = default;
		game_state& operator=(const game_state&) = delete;
		game_state& operator=(game_state&&) = default;

		unit_types_t unit_types;
		weapon_types_t weapon_types;
		upgrade_types_t upgrade_types;
		tech_types_t tech_types;

		std::array<type_indexed_array<bool, UnitTypes>, 12> unit_type_allowed;
		std::array<type_indexed_array<int, UpgradeTypes>, 12> max_upgrade_levels;
		std::array<type_indexed_array<bool, TechTypes>, 12> tech_available;

		int max_unit_width;
		int max_unit_height;

		size_t repulse_field_width;
		size_t repulse_field_height;
	};

	struct state_base_copyable {

		game_state* game;

		int order_timer_counter;
		int secondary_order_timer_counter;
		int current_frame;

		std::array<type_indexed_array<int, UpgradeTypes>, 12> upgrade_levels;
		std::array<type_indexed_array<bool, UpgradeTypes>, 12> upgrade_upgrading;
		std::array<type_indexed_array<bool, TechTypes>, 12> tech_researched;
		std::array<type_indexed_array<bool, TechTypes>, 12> tech_researching;

		std::array<type_indexed_array<int, UnitTypes>, 12> unit_counts;
		std::array<type_indexed_array<int, UnitTypes>, 12> completed_unit_counts;

		std::array<int, 12> factory_counts;
		std::array<int, 12> building_counts;
		std::array<int, 12> non_building_counts;

		std::array<int, 12> completed_factory_counts;
		std::array<int, 12> completed_building_counts;
		std::array<int, 12> completed_non_building_counts;

		std::array<int, 12> total_buildings_ever_completed;
		std::array<int, 12> total_non_buildings_ever_completed;

		std::array<std::array<fp1, 3>, 12> supply_used;
		std::array<std::array<fp1, 3>, 12> supply_available;

		std::vector<tile_t> tiles;
		std::vector<uint16_t> tiles_mega_tile_index;
		std::vector<bool> draw_creep_over;

		size_t active_orders_size;
		size_t active_bullets_size;
		size_t active_thingies_size;

		std::vector<uint8_t> repulse_field;

		int disruption_webbed_units;
	};

	struct state_base_non_copyable {

		state_base_non_copyable() = default;
		state_base_non_copyable(const state_base_non_copyable&) = delete;
		state_base_non_copyable(state_base_non_copyable&&) = default;
		state_base_non_copyable& operator=(const state_base_non_copyable&) = delete;
		state_base_non_copyable& operator=(state_base_non_copyable&&) = default;

		intrusive_list<unit_t, default_link_f> visible_units;
		intrusive_list<unit_t, default_link_f> hidden_units;

		std::array<intrusive_list<unit_t, void, &unit_t::player_units_link>, 12> player_units;

		object_container<unit_t, 1700, 17> units_container;

		intrusive_list<bullet_t, default_link_f> active_bullets;
		object_container<bullet_t, 100, 10> bullets_container;

		object_container<sprite_t, 2500, 25> sprites_container;

		object_container<image_t, 5000, 50> images_container;

		object_container<order_t, 2000, 20> orders_container;

		intrusive_list<thingy_t, default_link_f> active_thingies;
		intrusive_list<thingy_t, default_link_f> free_thingies;
		std::list<thingy_t> thingies;

		const unit_t* consider_collision_with_unit_bug;
		const unit_t* prev_bullet_source_unit;
	};

	struct state : state_base_copyable, state_base_non_copyable {
	};

	struct state_functions {

		state& st;
		const game_state& game_st = *st.game;

		explicit state_functions(state& st) : st(st) {}
		state_functions(state_functions&& n) : st(n.st) {}
		state_functions(const state_functions& n) : st(n.st) {}

		flingy_t* iscript_flingy = nullptr;
		unit_t* iscript_unit = nullptr;
		mutable size_t unit_finder_search_index = 0;

		struct execute_movement_struct {
			bool starting_movement = false;
			bool stopping_movement = false;
			fp8 speed;
			xy position;
			xy_fp8 exact_position;
			int pre_movement_flags;
			int post_movement_flags;
		};

		struct pathfinder {
			const unit_t* u = nullptr;
			const unit_t* target_unit = nullptr;
			xy source;
			rect unit_bb;
			rect target_unit_bb;
			xy destination;

			std::deque<xy> short_path;

			size_t current_short_path_index = 0;

			size_t short_highest_open_size = 0;
			size_t short_all_nodes_size = 0;
			size_t long_highest_open_size = 0;
			size_t long_all_nodes_size = 0;

			bool destination_reached = false;
			bool is_stuck = false;

			const unit_t* consider_collision_with_unit = nullptr;
			bool consider_collision_with_moving_units = false;
		};

		void u_set_movement_flag(flingy_t* u, int flag) {
			u->movement_flags |= flag;
		}
		void u_unset_movement_flag(flingy_t* u, int flag) {
			u->movement_flags &= ~flag;
		}

		void set_flingy_move_target(flingy_t* u, xy target_pos, unit_t* target_unit = nullptr) {
			if (u->move_target.pos == target_pos && (!target_unit || u->move_target.unit == target_unit)) return;
			u->move_target.pos = target_pos;
			u->move_target.unit = target_unit;
			u->next_movement_waypoint = target_pos;
			u_unset_movement_flag(u, 4);
			u_set_movement_flag(u, 1);
		}

		bool u_movement_flag(const flingy_t* u, int flag) const {
			return (u->movement_flags & flag) != 0;
		}

		void move_sprite(sprite_t* sprite, xy new_position) {
			if (sprite->position == new_position) return;
			sprite->position = new_position;
		}

		xy get_image_lo_offset(const image_t* image, size_t lo_index, size_t offset_index, bool use_frame_index_offset = false) const {
			// TODO: use factorio code
			return {};
		}

		void update_image_special_offset(image_t* image) {
			//set_image_offset(image, get_image_lo_offset(image->sprite->main_image, 2, 0));
		}

		size_t direction_index(direction_t dir) const {
			auto v = dir.fractional_part();
			if (v < 0) return 256 + v;
			else return v;
		}
		bool i_flag(const image_t* i, image_t::flags_t flag) const {
			return (i->flags & flag) != 0;
		}

		void i_set_flag(image_t* i, image_t::flags_t flag) {
			i->flags |= flag;
		}

		void i_unset_flag(image_t* i, image_t::flags_t flag) {
			i->flags &= ~flag;
		}
		void i_set_flag(image_t* i, image_t::flags_t flag, bool value) {
			if (value) i_set_flag(i, flag);
			else i_unset_flag(i, flag);
		}

		void set_image_modifier(image_t* image, int modifier) {
			image->modifier = modifier;
			if (modifier == 17) {
				image->modifier_data1 = 48;
				image->modifier_data2 = 2;
			}
			image->flags |= image_t::flag_redraw;
		}

		void update_image_frame_index(image_t* image) {
			size_t frame_index = image->frame_index_base + image->frame_index_offset;
			if (image->frame_index != frame_index) {
				image->frame_index = frame_index;
				image->flags |= image_t::flag_redraw;
			}
		}

		void set_image_frame_index_offset(image_t* image, size_t frame_index_offset, bool flipped) {
			image->frame_index_offset = frame_index_offset;
			i_set_flag(image, image_t::flag_horizontally_flipped, flipped);
			set_image_modifier(image, image->modifier);
			update_image_frame_index(image);
		}

		void update_unit_heading(flingy_t* u, direction_t velocity_direction) {
			u->next_velocity_direction = velocity_direction;
			if (!u_movement_flag(u, 2) || u_movement_flag(u, 1)) {
				direction_t turn = u->desired_velocity_direction - u->heading;
				if (turn > direction_t::truncate(u->flingy_turn_rate)) turn = direction_t::truncate(u->flingy_turn_rate);
				else if (turn < direction_t::truncate(-u->flingy_turn_rate)) turn = -direction_t::truncate(u->flingy_turn_rate);
				u->heading += turn;
				if (u->flingy_type->id >= (FlingyTypes)0x8d && u->flingy_type->id <= (FlingyTypes)0xab) {
					u->flingy_turn_rate += 1_fp8;
				}
				else if (u->flingy_type->id >= (FlingyTypes)0xc9 && u->flingy_type->id <= (FlingyTypes)0xce) {
					u->flingy_turn_rate += 1_fp8;
				}
				if (velocity_direction == u->desired_velocity_direction) {
					if (u->heading == u->desired_velocity_direction) {
						u_unset_movement_flag(u, 1);
					}
				}
			}
			auto heading = u->heading;
			// TODO: Image heading/direction
		}
		bool s_flag(const sprite_t* s, sprite_t::flags_t flag) const {
			return (s->flags & flag) != 0;
		}

		bool iscript_run_anim(image_t* image, int new_anim) {
			// TODO: Iscript execution in Factorio
			return false;
		}

		void sprite_run_anim(sprite_t* sprite, int anim) {
			for (auto i = sprite->images.begin(); i != sprite->images.end();) {
				image_t* image = &*i++;
				iscript_run_anim(image, anim);
			}
		}

		bool finish_flingy_movement(flingy_t* u, execute_movement_struct& ems) {
			bool moved = u->position != ems.position;
			u->movement_flags = ems.post_movement_flags;
			u->next_speed = u->current_speed;
			u->position = ems.position;
			u->exact_position = ems.exact_position;
			move_sprite(u->sprite, u->position);
			update_unit_heading(u, u->current_velocity_direction);
			if (ems.stopping_movement) {
				if (!s_flag(u->sprite, sprite_t::flag_iscript_nobrk)) {
					sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
				}
			}
			else if (ems.starting_movement) {
				sprite_run_anim(u->sprite, iscript_anims::Walking);
			}
			return moved;
		}

		size_t tile_index(xy pos) const {
			// TODO
			return 0;
		}

		bool finish_unit_movement(unit_t* u, execute_movement_struct& ems) {
			auto prev_pos = u->position;
			if (!finish_flingy_movement(u, ems)) return false;
			//if (tile_index(prev_pos) != tile_index(u->position)) ems.refresh_vision = true;
			return true;
		}
		int xy_length(xy vec) const {
			unsigned int x = std::abs(vec.x);
			unsigned int y = std::abs(vec.y);
			if (x < y) std::swap(x, y);
			if (x / 4 < y) x = x - x / 16 + y * 3 / 8 - x / 64 + y * 3 / 256;
			return x;
		}

		fp8 xy_length(xy_fp8 vec) const {
			return fp8::from_raw(xy_length({ (int)vec.x.raw_value, (int)vec.y.raw_value }));
		}

		bool is_moving_along_path(const unit_t* u) const {
			if (!u->path) return false;
			if (u->path->next == u->sprite->position) return false;
			if (u->path->next == u->move_target.pos) return true;
			if (u->flingy_movement_type != 0) return true;
			int remaining_distance = xy_length(u->path->next - u->sprite->position);
			if (remaining_distance > 16) return true;
			auto remaining_turn = fp8::extend(u->desired_velocity_direction - u->next_velocity_direction).abs();
			if (remaining_turn.raw_value <= remaining_distance * 2) return true;
			if (u->path->current_short_path_index >= u->path->short_path.size() - 1) {
				return false;
			}
			return true;
		}

		path_t* create_single_step_path(xy source, xy destination) {
			// TODO
			path_t* path = nullptr;
			if (!path) return nullptr;
			path->delay = 0;
			// creation_frame is not set here :(
			path->state_flags = 0;

			path->short_path = { destination };
			path->current_short_path_index = 0;

			path->source = source;
			path->destination = destination;
			path->next = destination;

			return path;
		}

		bool u_status_flag(const unit_t* u, unit_t::status_flags_t flag) const {
			return (u->status_flags & flag) != 0;
		}

		void u_unset_status_flag(unit_t* u, unit_t::status_flags_t flag) {
			u->status_flags &= ~flag;
		}

		bool u_immovable(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_immovable);
		}

		rect unit_type_bounding_box(const unit_type_t* unit_type, xy origin) const {
			return { origin - unit_type->dimensions.from, origin + unit_type->dimensions.to + xy(1, 1) };
		}
		void set_unit_move_target(unit_t* u, xy move_target) {
			if (u->move_target.pos == move_target) return;
			if (u->path) u->path->state_flags |= 1;
			move_target = move_target;
			set_flingy_move_target(u, move_target);
			if (u_immovable(u)) u_unset_status_flag(u, unit_t::status_flag_immovable);
			u->move_target_timer = 15;
			if (!u->order_queue.empty() && !u->order_queue.front().order_type->unk7) {
				u_set_movement_flag(u, 0x20);
			}
			else {
				u_unset_movement_flag(u, 0x20);
			}
		}

		void set_unit_move_target(unit_t* u, unit_t* target) {
			xy target_pos = target->sprite->position;
			if (u->move_target.pos == target_pos && u->move_target.unit == target) return;
			if (u->path) u->path->state_flags |= 1;
			set_flingy_move_target(u, target_pos, target);
			if (u_immovable(u)) u_unset_status_flag(u, unit_t::status_flag_immovable);
			u->move_target_timer = 15;
			if (!u->order_queue.empty() && !u->order_queue.front().order_type->unk7) {
				u_set_movement_flag(u, 0x20);
			}
			else {
				u_unset_movement_flag(u, 0x20);
			}
		}


		bool u_ground_unit(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_ground_unit);
		}

		void set_next_target_waypoint(flingy_t* u, xy pos) {
			if (u->next_target_waypoint == pos) return;
			u->next_target_waypoint = pos;
		}

		void free_path(unit_t* u) {
			if (!u->path) return;
			u->path = nullptr;
		}

		bool pathfinder_unit_can_collide_with(const pathfinder& pf, const unit_t* target) const {
			return pathfinder_unit_can_collide_with(pf.u, target, pf.consider_collision_with_unit, pf.consider_collision_with_moving_units);
		}

		bool unit_is_special_beacon(unit_type_autocast ut) const {
			return ut->id >= UnitTypes::Special_Zerg_Beacon && ut->id <= UnitTypes::Special_Protoss_Flag_Beacon;
		}

		bool pathfinder_find(pathfinder& pf, bool short_path_only = false) {
			pf.unit_bb = unit_type_inner_bounding_box(pf.u->unit_type);
			pf.short_highest_open_size = 0;
			pf.short_all_nodes_size = 0;
			pf.long_all_nodes_size = 0;
			pf.long_highest_open_size = 0;
			pf.destination_reached = false;
			pf.is_stuck = false;

			// TODO: Factorio paths
			return true;
		}

		void u_set_status_flag(unit_t* u, unit_t::status_flags_t flag, bool value) {
			if (value) u->status_flags |= flag;
			else u->status_flags &= ~flag;
		}

		bool path_progress(unit_t* u, xy to, const unit_t* consider_collision_with_unit = nullptr, bool consider_collision_with_moving_units = false) {
			u_unset_movement_flag(u, 0x40);
			u_set_movement_flag(u, 0x10);
			pathfinder pf;
			pf.consider_collision_with_unit = consider_collision_with_unit;
			pf.consider_collision_with_moving_units = consider_collision_with_moving_units;
			bool find_new_path = true;
			if (u->path) {
				++u->path->current_short_path_index;
				if (u->path->current_short_path_index < u->path->short_path.size()) {
					find_new_path = false;
				}
				else {
					pf.u = u;
					pf.source = u->sprite->position;
					pf.destination = u->path->destination;
					pf.short_path = std::move(u->path->short_path);
					pf.current_short_path_index = u->path->current_short_path_index;
					free_path(u);
					if (pf.source != pf.destination) {
						if (pathfinder_find(pf, true)) {
							if (!pf.short_path.empty()) find_new_path = false;
						}
					}
				}
			}
			if (find_new_path) {
				pf.u = u;
				pf.source = u->sprite->position;
				pf.destination = to;
				pathfinder_find(pf);
				if (pf.short_path.empty()) return false;
			}
			path_t* path = u->path;
			if (!path) {
				if (pf.destination_reached) {
					if (to != pf.destination) {
						to = pf.destination;
						xy move_target = to;
						auto* move_target_unit = u->move_target.unit;
						if (move_target_unit && u_movement_flag(move_target_unit, 2)) {
							fp8 halt_distance = unit_halt_distance(u);
							xy pos = move_target_unit->sprite->position + to_xy(direction_xy(move_target_unit->next_velocity_direction, halt_distance * 3));
							move_target = pos;
						}
						set_flingy_move_target(u, move_target);
						u->move_target.unit = move_target_unit;
						u_set_status_flag(u, unit_t::status_flag_immovable, pf.is_stuck);
					}
				}

				// TODO
				path = nullptr;
				if (!path) return false;
				path->delay = 0;
				path->creation_frame = st.current_frame;
				path->state_flags = 0;
				path->short_path = std::move(pf.short_path);
				path->current_short_path_index = 0;

				path->source = u->sprite->position;
				path->destination = to;

				u->path = path;
			}
			path->next = path->short_path.at(path->current_short_path_index);
			if (path->next == u->move_target.pos) u_unset_movement_flag(u, 0x10);
			else if (xy_length(path->destination - path->next) < 16) u_set_movement_flag(u, 0x40);
			return true;
		}

		bool unit_path_to(unit_t* u, xy to, const unit_t* consider_collision_with_unit = nullptr, bool consider_collision_with_moving_units = false) {
			if (is_moving_along_path(u)) return true;
			if (!u_ground_unit(u)) {
				set_unit_move_target(u, to);
				free_path(u);
				u->path = create_single_step_path(u->sprite->position, to);
				if (!u->path) return false;
				return true;
			}
			if (!path_progress(u, to, consider_collision_with_unit, consider_collision_with_moving_units)) return false;
			set_next_target_waypoint(u, u->path->next);
			if (u->next_movement_waypoint != u->path->next) {
				u->next_movement_waypoint = u->path->next;
				u_set_movement_flag(u, 1);
			}
			return true;
		}
		
		bool unit_is_at_move_target(const flingy_t* u) const {
			return u->sprite->position == u->move_target.pos;
		}

		bool u_collision(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_collision);
		}

		bool unit_update_path_movement_state(unit_t* u, bool allow_new_path) {
			if (unit_is_at_move_target(u) || u_movement_flag(u, 4)) {
				u->movement_state = movement_states::UM_AtMoveTarget;
				return true;
			}
			if (u_collision(u) && u_ground_unit(u)) {
				free_path(u);
				u->movement_state = movement_states::UM_CheckIllegal;
				return true;
			}
			auto next_movement_state = movement_states::UM_AnotherPath;
			if (!allow_new_path || u->path) {
				if (!u->path || ~u->path->state_flags & 1) return false;
				next_movement_state = movement_states::UM_NewMoveTarget;
			}
			if (u->movement_state >= movement_states::UM_FixCollision && u->movement_state <= movement_states::UM_TerrainSlide) {
				next_movement_state = movement_states::UM_TurnAndStart;
			}
			u->movement_state = next_movement_state;
			return true;
		}

		xy_fp8 direction_xy(direction_t dir, fp8 length) const {
			return direction_table[direction_index(dir)] * length;
		}

		xy_fp8 direction_xy(direction_t dir, int length) const {
			return direction_table[direction_index(dir)] * length;
		}

		xy_fp8 direction_xy(direction_t dir) const {
			return direction_table[direction_index(dir)];
		}

		void set_current_speed(flingy_t* u, fp8 current_speed) {
			if (u->current_speed == current_speed) return;
			u->current_speed = current_speed;
			u->velocity = direction_xy(u->current_velocity_direction, u->current_speed);
		}

		void set_next_speed(flingy_t* u, fp8 next_speed) {
			u->next_speed = next_speed;
			set_current_speed(u, next_speed);
		}

		fp8 unit_halt_distance(const flingy_t* u) const {
			ufp8 speed = u->next_speed.as_unsigned();
			if (speed == ufp8::zero()) return 0_fp8;
			if (u->flingy_movement_type != 0) return 0_fp8;
			if (speed == u->flingy_type->top_speed.as_unsigned() && u->flingy_acceleration == u->flingy_type->acceleration) {
				return u->flingy_type->halt_distance;
			}
			else {
				return (ufp8::multiply_divide(speed, speed, u->flingy_acceleration.as_unsigned()) / 2u).as_signed();
			}
		}

		xy to_xy(xy_fp8 position) const {
			return { (int)position.x.integer_part(), (int)position.y.integer_part() };
		}

		void stop_flingy(flingy_t* u) {
			if (u_movement_flag(u, 4)) return;
			u_unset_movement_flag(u, 0x10);
			u_unset_movement_flag(u, 0x20);
			u_unset_movement_flag(u, 0x40);
			u->move_target.pos = u->position;
			u->move_target.unit = nullptr;
			u->next_movement_waypoint = u->position;
			if (u_movement_flag(u, 2) && u->flingy_movement_type == 0) {
				fp8 d = unit_halt_distance(u);
				u->move_target.pos = to_xy(u->exact_position + direction_xy(u->next_velocity_direction, d));
				u->next_movement_waypoint = u->move_target.pos;
				if (!unit_is_at_move_target(u)) u_set_movement_flag(u, 4);
			}
		}

		void stop_unit(unit_t* u) {
			if (u->pathing_flags & 2) u->pathing_flags |= 4;
			stop_flingy(u);
			xy move_target = u->move_target.pos;
			if (u->move_target.pos != move_target) {
				u->move_target.pos = move_target;
				u->next_movement_waypoint = move_target;
			}
			u->move_target_timer = 15;
		}

		void u_set_status_flag(unit_t* u, unit_t::status_flags_t flag) {
			u->status_flags |= flag;
		}
		void set_unit_immovable(unit_t* u) {
			set_next_speed(u, 0_fp8);
			stop_unit(u);
			set_unit_move_target(u, u->sprite->position);
			u_set_status_flag(u, unit_t::status_flag_immovable);
		}

		bool u_order_not_interruptible(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_order_not_interruptible);
		}
		bool u_iscript_nobrk(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_iscript_nobrk);
		}
		void update_unit_pathing_collision(unit_t* u) {
			if (~u->movement_flags & 2) return;
			if (u->pathing_collision_counter <= 2) return;
			if (u_order_not_interruptible(u)) return;
			if (u_iscript_nobrk(u)) return;
			u->movement_flags &= ~2;
			sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
		}

		rect unit_sprite_inner_bounding_box(const unit_t* u) const {
			return { u->sprite->position - u->unit_type->dimensions.from, u->sprite->position + u->unit_type->dimensions.to };
		}


		int cardinal_direction_from_to(const unit_t* from_u, const unit_t* to_u) const {
			auto a_bb = unit_sprite_inner_bounding_box(to_u);
			auto b_bb = unit_sprite_inner_bounding_box(from_u);
			if (a_bb.to.x < b_bb.from.x) return 3;
			if (a_bb.from.x > b_bb.to.x) return 1;
			if (a_bb.to.y < b_bb.from.y) return 0;
			if (a_bb.from.y > b_bb.to.y) return 2;
			int up_distance = std::abs(a_bb.to.y - b_bb.from.y);
			int right_distance = std::abs(a_bb.from.x - b_bb.to.x);
			int down_distance = std::abs(a_bb.from.y - b_bb.to.y);
			int left_distance = std::abs(a_bb.to.x - b_bb.from.x);
			std::array<int, 4> distances = { right_distance, left_distance, down_distance, up_distance };
			std::array<int, 4> r = { 1, 3, 2, 0 };
			return r[get_best_score(distances, identity()) - distances.begin()];
		}

		bool us_flag(const thingy_t* u, sprite_t::flags_t flag) const {
			return (u->sprite->flags & flag) != 0;
		}
		bool us_hidden(const thingy_t* u) const {
			return us_flag(u, sprite_t::flag_hidden);
		}

		template<size_t integer_bits>
		direction_t atan(fixed_point<integer_bits, 8, true> x) const {
			bool negative = x < decltype(x)::zero();
			if (negative) x = -x;
			typename decltype(x)::raw_unsigned_type uv = x.raw_value;
			size_t r = std::lower_bound(tan_table.begin(), tan_table.end(), uv) - tan_table.begin();
			return negative ? -direction_t::from_raw((direction_t::raw_type)r) : direction_t::from_raw((direction_t::raw_type)r);
		}

		direction_t xy_direction(xy_fp8 pos) const {
			if (pos.x == 0_fp8) return pos.y <= 0_fp8 ? 0_dir : -128_dir;
			direction_t r = atan(pos.y / pos.x);
			if (pos.x > 0_fp8) r += 64_dir;
			else r = -64_dir + r;
			return r;
		}

		direction_t xy_direction(xy pos) const {
			if (pos.x == 0) return pos.y <= 0 ? 0_dir : -128_dir;
			direction_t r = atan(fp8::integer(pos.y) / pos.x);
			if (pos.x > 0) r = 64_dir + r;
			else r = -64_dir + r;
			return r;
		}

		rect unit_type_inner_bounding_box(const unit_type_t* unit_type) const {
			return { -unit_type->dimensions.from, unit_type->dimensions.to };
		}
		rect unit_type_inner_bounding_box(const unit_type_t* unit_type, xy origin) const {
			return { origin - unit_type->dimensions.from, origin + unit_type->dimensions.to };
		}
		rect unit_inner_bounding_box(const unit_t* u, xy origin) const {
			return unit_type_inner_bounding_box(u->unit_type, origin);
		}

		bool unit_finder_unit_in_bounds(unit_t* u, rect bounds) const {
			return is_intersecting(u->unit_finder_bounding_box, bounds);
		}

		rect unit_type_bounding_box(const unit_type_t* unit_type) const {
			return { -unit_type->dimensions.from, unit_type->dimensions.to + xy(1, 1) };
		}

		unit_t* get_largest_blocking_unit(const unit_t* u, rect bounds) const {
			int largest_unit_area = 0;
			unit_t* largest_unit = nullptr;
			for (unit_t* nu : find_units(bounds)) {
				if (unit_can_collide_with(u, nu) && unit_finder_unit_in_bounds(nu, bounds)) {
					rect n_bb = unit_type_bounding_box(nu->unit_type);
					int p = (n_bb.to.x - n_bb.from.x) * (n_bb.to.y - n_bb.from.y);
					if (p > largest_unit_area) {
						largest_unit_area = p;
						largest_unit = nu;
					}
				}
			}
			return largest_unit;
		}

		const std::vector<vf4_entry>& vf4() const {
			return global_st.get_vf4(0);
		}

		bool is_walkable(xy pos) const {
			size_t index = tile_index(pos);
			auto& tile = st.tiles[index];
			if (tile.flags & tile_t::flag_has_creep) return true;
			if (tile.flags & tile_t::flag_partially_walkable) {
				size_t ux = pos.x;
				size_t uy = pos.y;
				size_t megatile_index = st.tiles_mega_tile_index[index];
				int flags = vf4().at(megatile_index).flags[uy / 8 % 4 * 4 + ux / 8 % 4];
				return flags & vf4_entry::flag_walkable;
			}
			if (tile.flags & tile_t::flag_walkable) return true;
			return false;
		}

		bool can_fit_at(xy pos, std::array<int, 4> inner) const {
			// TODO: Factorio version
			return true;
		}

		bool unit_type_can_fit_at(const unit_type_t* unit_type, xy pos) const {
			if (!is_walkable(pos)) return false;
			std::array<int, 4> inner;
			inner[0] = unit_type->dimensions.from.y;
			inner[1] = -unit_type->dimensions.to.x;
			inner[2] = -unit_type->dimensions.to.y;
			inner[3] = unit_type->dimensions.from.x;
			return can_fit_at(pos, inner);
		}

		std::pair<bool, unit_t*> is_blocked(const unit_t* u, xy pos) const {
			rect bounds = unit_inner_bounding_box(u, pos);
			unit_t* largest_unit = get_largest_blocking_unit(u, bounds);
			// TODO: Factorio version
			return std::make_pair(true, largest_unit);
		}

		bool collision_get_slide_free_direction(const unit_t* u, const unit_t* collision_unit, direction_t& slide_free_direction) const {
			slide_free_direction = -1_dir;
			if (us_hidden(collision_unit)) return false;
			auto target_dir = xy_direction(u->next_movement_waypoint - u->sprite->position);
			auto target_dir_quadrant = direction_index(target_dir) / 64;
			auto dir_err = fp8::extend(target_dir - u->current_velocity_direction).abs();
			if (dir_err >= 80_fp8) return false;
			int left_x = collision_unit->unit_finder_bounding_box.from.x - u->unit_type->dimensions.to.x - 1;
			int right_x = collision_unit->unit_finder_bounding_box.to.x + u->unit_type->dimensions.from.x + 1;
			int up_y = collision_unit->unit_finder_bounding_box.from.y - u->unit_type->dimensions.to.y - 1;
			int down_y = collision_unit->unit_finder_bounding_box.to.y + u->unit_type->dimensions.from.y + 1;
			xy target_pos;
			switch (cardinal_direction_from_to(u, collision_unit)) {
			case 0:
				target_pos.y = down_y;
				if (target_dir_quadrant == 3) slide_free_direction = -64_dir;
				else if (target_dir_quadrant == 0) slide_free_direction = 64_dir;
				break;
			case 1:
				target_pos.x = left_x;
				if (target_dir_quadrant == 0) slide_free_direction = 0_dir;
				else if (target_dir_quadrant == 1) slide_free_direction = -128_dir;
				break;
			case 2:
				target_pos.y = up_y;
				if (target_dir_quadrant == 1) slide_free_direction = 64_dir;
				else if (target_dir_quadrant == 2) slide_free_direction = -64_dir;
				break;
			case 3:
				target_pos.x = right_x;
				if (target_dir_quadrant == 2) slide_free_direction = -128_dir;
				else if (target_dir_quadrant == 3) slide_free_direction = 0_dir;
				break;
			}
			for (int i = 0; i != 2; ++i) {
				if (slide_free_direction == 0_dir) {
					target_pos.y = up_y;
					if (!is_blocked(u, target_pos).first) return true;
					slide_free_direction = -128_dir;
				}
				else if (slide_free_direction == -128_dir) {
					target_pos.y = down_y;
					if (!is_blocked(u, target_pos).first) return true;
					slide_free_direction = 0_dir;
				}
				else if (slide_free_direction == 64_dir) {
					target_pos.x = right_x;
					if (!is_blocked(u, target_pos).first) return true;
					slide_free_direction = -64_dir;
				}
				else if (slide_free_direction == -64_dir) {
					target_pos.x = left_x;
					if (!is_blocked(u, target_pos).first) return true;
					slide_free_direction = 64_dir;
				}
			}

			return false;
		}

		void reset_movement_state(unit_t* u) {
			free_path(u);
			u->movement_state = movement_states::UM_Init;
			if (u->sprite->elevation_level < 12) u->pathing_flags |= 1;
			else u->pathing_flags &= ~1;
		}

		bool ut_flag(unit_type_autocast ut, unit_type_t::flags_t flag) const {
			return (ut->flags & flag) != 0;
		}
		bool ut_turret(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_turret);
		}

		bool unit_dead(const unit_t* u) const {
			if (!u->order_type) return true;
			return u->order_type->id == Orders::Die && u->order_state == 1;
		}

		bool u_in_bunker(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_in_bunker);
		}


		direction_t unit_turn_rate(const flingy_t* u, direction_t desired_turn) const {
			ufp8 uturn_rate = u->flingy_turn_rate.as_unsigned();
			if (u->flingy_movement_type != 2) uturn_rate /= 2u;
			fp8 turn_rate = uturn_rate.as_signed();
			fp8 turn = fp8::extend(desired_turn);
			if (turn > turn_rate) turn = turn_rate;
			else if (turn < -turn_rate) turn = -turn_rate;
			return direction_t::truncate(turn);
		}

		void set_current_velocity_direction(flingy_t* u, direction_t current_velocity_direction) {
			if (u->current_velocity_direction == current_velocity_direction) return;
			u->current_velocity_direction = current_velocity_direction;
			u->velocity = direction_xy(current_velocity_direction, u->current_speed);
		}
		void set_desired_velocity_direction(flingy_t* u, direction_t desired_velocity_direction) {
			u->desired_velocity_direction = desired_velocity_direction;
			if (u->next_velocity_direction != desired_velocity_direction) {
				auto turn = unit_turn_rate(u, desired_velocity_direction - u->next_velocity_direction);
				set_current_velocity_direction(u, u->next_velocity_direction + turn);
			}
			else {
				set_current_velocity_direction(u, desired_velocity_direction);
			}
		}

		void update_current_velocity_direction_towards_waypoint(flingy_t* u) {
			if (u->position != u->next_movement_waypoint) {
				set_desired_velocity_direction(u, xy_direction(u->next_movement_waypoint - u->position));
			}
			else {
				if (u->position != u->next_target_waypoint) {
					set_desired_velocity_direction(u, xy_direction(u->next_target_waypoint - u->position));
				}
				else {
					set_desired_velocity_direction(u, u->heading);
				}
			}
		}

		xy_fp8 to_xy_fp8(xy position) const {
			return { fp8::integer(position.x), fp8::integer(position.y) };
		}
		void update_current_speed_towards_waypoint(flingy_t* u) {
			if (u->flingy_movement_type == 0) {
				if (unit_is_at_move_target(u)) {
					if (u->next_speed < 192_fp8) {
						if (!u_movement_flag(u, 0x20) && !u_movement_flag(u, 0x10)) {
							u_unset_movement_flag(u, 4);
							set_current_speed(u, 0_fp8);
							return;
						}
					}
				}
			}
			else if (u->flingy_movement_type == 1) {
				if (unit_is_at_move_target(u)) {
					u_unset_movement_flag(u, 4);
					set_current_speed(u, 0_fp8);
					return;
				}
			}
			else if (u->flingy_movement_type == 2) {
				if (unit_is_at_move_target(u)) {
					u_unset_movement_flag(u, 4);
					set_current_speed(u, 0_fp8);
				}
				else {
					if (!u_movement_flag(u, 1)) {
						set_current_speed(u, u->next_speed);
					}
					else {
						auto heading_error = fp8::extend(u->heading - u->desired_velocity_direction).abs();
						if (heading_error >= 32_fp8) {
							if (u_movement_flag(u, 2)) {
								u_unset_movement_flag(u, 2);
								u_unset_movement_flag(u, 4);
								set_current_speed(u, 0_fp8);
							}
						}
						else {
							set_current_speed(u, u->next_speed);
						}
					}
				}
				return;
			}
			set_current_speed(u, u->next_speed);
			int d = xy_length(u->next_movement_waypoint - u->position);
			bool accelerate = false;
			if (u->current_velocity_direction == u->desired_velocity_direction) accelerate = true;
			else if (d >= 32) accelerate = true;
			else {
				fp8 turn_rate = u->flingy_turn_rate;
				fp8 diff = fp8::extend(u->desired_velocity_direction - u->current_velocity_direction).abs();

				unsigned int val = fp8::divide_multiply(diff * 2 + turn_rate - 1_fp8, turn_rate, u->next_speed).integer_part();
				if (val * 3 / 2 <= (unsigned int)d) accelerate = true;
			}
			if (accelerate) {
				if (u->flingy_movement_type == 0) {
					if (!u_movement_flag(u, 0x20) || u->next_movement_waypoint != u->move_target.pos) {
						if (!u_movement_flag(u, 0x10) || u_movement_flag(u, 0x40)) {
							fp8 remaining_d = xy_length(to_xy_fp8(u->next_movement_waypoint) - u->exact_position);
							if (unit_halt_distance(u) >= remaining_d) accelerate = false;
						}
					}
				}
			}
			fp8 speed = u->current_speed;
			if (accelerate) speed += u->flingy_acceleration;
			else speed -= u->flingy_acceleration;
			if (speed < 0_fp8) speed = 0_fp8;
			else if (speed > u->flingy_top_speed) speed = u->flingy_top_speed;
			set_current_speed(u, speed);
		}

		void set_movement_flags(flingy_t* u, execute_movement_struct& ems) {
			ems.starting_movement = false;
			ems.stopping_movement = false;
			if (!unit_is_at_move_target(u)) {
				if (!u_movement_flag(u, 2)) {
					if (u->flingy_movement_type != 2 || !u_movement_flag(u, 8)) u_set_movement_flag(u, 2);
					if (!u_movement_flag(u, 8)) ems.starting_movement = true;
				}
			}
			else {
				if (u_movement_flag(u, 2)) {
					u_unset_movement_flag(u, 2);
					if (!u_movement_flag(u, 8)) ems.stopping_movement = true;
				}
			}
		}

		void set_movement_values(flingy_t* u, execute_movement_struct& ems) {
			ems.speed = u->current_speed;
			if (!u_movement_flag(u, 2) || u->current_speed == 0_fp8) {
				ems.position = u->position;
				ems.exact_position = u->exact_position;
			}
			else {
				fp8 remaining_d = xy_length(to_xy_fp8(u->next_movement_waypoint) - u->exact_position);
				if (u->current_speed >= remaining_d) {
					ems.position = u->next_movement_waypoint;
					ems.exact_position = to_xy_fp8(ems.position);
					ems.speed = remaining_d;
				}
				else {
					ems.exact_position = u->exact_position + u->velocity;
					ems.position = to_xy(ems.exact_position);
				}
				if (u->flingy_movement_type == 2) {
					set_current_speed(u, 0_fp8);
				}
			}
		}

		void update_unit_movement_values(flingy_t* u, execute_movement_struct& ems) {
			ems.pre_movement_flags = u->movement_flags;
			update_current_velocity_direction_towards_waypoint(u);
			update_current_speed_towards_waypoint(u);
			set_movement_flags(u, ems);
			set_movement_values(u, ems);
			ems.post_movement_flags = u->movement_flags;
			u->movement_flags = ems.pre_movement_flags;
		}

		bool u_burrowed(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_burrowed);
		}

		bool u_can_turn(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_can_turn);
		}
		bool u_can_move(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_can_move);
		}
		bool movement_UM_Init(unit_t* u, execute_movement_struct& ems) {
			u->pathing_flags &= ~(1 | 2);
			if (u->sprite->elevation_level < 12) u->pathing_flags |= 1;
			u->terrain_no_collision_bounds = { {0, 0}, {0, 0} };
			int next_state = movement_states::UM_Lump;
			if (!ut_turret(u) && u_iscript_nobrk(u)) {
				next_state = movement_states::UM_InitSeq;
			}
			else if (!u->sprite || unit_dead(u)) {
				next_state = movement_states::UM_Lump;
			}
			else if (u_in_bunker(u)) {
				next_state = movement_states::UM_Bunker;
			}
			else if (us_hidden(u)) {
				if (u_movement_flag(u, 2) || !unit_is_at_move_target(u)) {
					set_unit_immovable(u);
					update_unit_movement_values(u, ems);
					finish_unit_movement(u, ems);
				}
				next_state = movement_states::UM_Hidden;
			}
			else if (u_burrowed(u)) {
				next_state = movement_states::UM_Lump;
			}
			else if (u_can_move(u)) {
				next_state = u->pathing_flags & 1 ? movement_states::UM_AtRest : movement_states::UM_Flyer;
			}
			else if (u_can_turn(u)) {
				next_state = ut_turret(u) ? movement_states::UM_Turret : movement_states::UM_BldgTurret;
			}
			else if (u->pathing_flags & 1 && (u_movement_flag(u, 2) || !unit_is_at_move_target(u))) {
				next_state = movement_states::UM_LumpWannabe;
			}
			u->movement_state = next_state;
			return true;
		}


		bool u_no_collide(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_no_collide);
		}
		bool u_gathering(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_gathering);
		}
		bool u_grounded_building(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_grounded_building);
		}
		bool unit_target_is_enemy(const unit_t* u, const unit_t* target) const {
			// TODO: Factorio check
			return true;
		}

		bool unit_is(unit_type_autocast ut, UnitTypes unit_type_id) const {
			return ut->id == unit_type_id;
		}
		bool unit_can_collide_with(const unit_t* u, const unit_t* target) const {
			if (target == u) return false;
			if (~target->pathing_flags & 1) return false;
			if (u_no_collide(target)) return false;
			if (u_status_flag(target, unit_t::status_flag_400000)) {
				if (unit_target_is_enemy(u, target)) return false;
			}
			if (u_gathering(u) && !u_grounded_building(target)) {
				if (!u_gathering(target)) return false;
				if (u->order_type->id == Orders::ReturnGas) return false;
				if (target->order_type->id != Orders::WaitForGas) return false;
			}
			if (unit_is(u, UnitTypes::Zerg_Larva)) {
				if (!u_grounded_building(target)) return false;
			}
			else if (unit_is(target, UnitTypes::Zerg_Larva)) {
				return false;
			}
			return true;
		}

		unit_t* check_unit_movement_unit_collision(unit_t* u, const execute_movement_struct& ems) {
			if (us_hidden(u)) return nullptr;
			xy movement = ems.position - u->sprite->position;

			auto cmp_u = [&](int a, auto& b) {
				return a < b.value;
			};
			auto cmp_l = [&](auto& a, int b) {
				return a.value < b;
			};

			auto new_bb = u->unit_finder_bounding_box;
			new_bb.from += movement;
			new_bb.to += movement;

			// TODO:
			// Check collision with `unit_can_collide_with(u, iter_target) && u_ground_unit(iter_target)`

			return nullptr;
		}

		unit_t* check_ground_unit_movement_unit_collision(unit_t* u, const execute_movement_struct& ems) {
			if (u_ground_unit(u)) {
				return check_unit_movement_unit_collision(u, ems);
			}
			else {
				return nullptr;
			}
		}


		bool check_unit_movement_terrain_collision(unit_t* u, xy movement) {
			xy new_pos = u->sprite->position + movement;
			if (new_pos.x >= u->terrain_no_collision_bounds.from.x && new_pos.y >= u->terrain_no_collision_bounds.from.y) {
				if (new_pos.x <= u->terrain_no_collision_bounds.to.x && new_pos.y <= u->terrain_no_collision_bounds.to.y) return false;
			}
			xy pos = u->sprite->position;
			rect bounds = { pos - xy(128, 128), pos + xy(128, 128) };

			std::array<int, 4> inner;
			inner[0] = u->unit_type->dimensions.from.y;
			inner[1] = -u->unit_type->dimensions.to.x;
			inner[2] = -u->unit_type->dimensions.to.y;
			inner[3] = u->unit_type->dimensions.from.x;

			// TODO: Factorio version
			return false;
		}

		rect unit_bounding_box(const unit_t* u, xy origin) const {
			return unit_type_bounding_box(u->unit_type, origin);
		}

		bool check_unit_movement_terrain_collision(unit_t* u, const execute_movement_struct& ems) {
			if (u_ground_unit(u)) {
				return check_unit_movement_terrain_collision(u, ems.position - u->sprite->position);
			}
			else {
				return false;
			}
		}

		bool movement_UM_AtRest(unit_t* u, execute_movement_struct& ems) {
			if (!unit_is_at_move_target(u)) {
				if (u->pathing_collision_counter) {
					if (u->pathing_collision_counter > 2) u->pathing_collision_counter = 2;
					else --u->pathing_collision_counter;
				}
			}
			else u->pathing_collision_counter = 0;
			auto go_to_next_waypoint = [&]() {
				if (u_movement_flag(u, 4)) return true;
				if (unit_is_at_move_target(u)) {
					if (u_movement_flag(u, 2)) return true;
					if (u->position != u->next_target_waypoint) {
						auto dir = xy_direction(u->next_target_waypoint - u->position);
						if (u->heading != dir) return true;
						if (u->next_velocity_direction != dir) return true;
					}
				}
				return false;
			};
			bool going_to_next_waypoint = false;
			if (go_to_next_waypoint()) {
				going_to_next_waypoint = true;
				update_unit_movement_values(u, ems);
				if (check_ground_unit_movement_unit_collision(u, ems) || check_unit_movement_terrain_collision(u, ems)) {
					set_next_speed(u, 0_fp8);
					u->movement_flags = ems.post_movement_flags;
					update_unit_heading(u, u->current_velocity_direction);
					if (ems.stopping_movement) {
						if (!s_flag(u->sprite, sprite_t::flag_iscript_nobrk)) {
							sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
						}
					}
					else if (ems.starting_movement) {
						sprite_run_anim(u->sprite, iscript_anims::Walking);
					}

					set_flingy_move_target(u, u->sprite->position);
					stop_unit(u);
				}
				else {
					finish_unit_movement(u, ems);
				}
			}
			if (u_collision(u) && u_ground_unit(u)) {
				u->movement_state = movement_states::UM_CheckIllegal;
				return false;
			}
			if (!unit_is_at_move_target(u) && !u_movement_flag(u, 4)) {
				u->movement_state = movement_states::UM_StartPath;
				return true;
			}
			if (!going_to_next_waypoint) {
				u->next_speed = 0_fp8;
				if (u->current_speed != 0_fp8) {
					u->current_speed = 0_fp8;
					u->velocity = {};
				}
				set_next_target_waypoint(u, u->sprite->position);
				u->movement_state = movement_states::UM_Dormant;
			}
			return false;
		}

		bool get_unique_sided_positions_within_bounds(xy& from, xy& to, rect bounds) const {
			auto get_flags = [&](xy pos) {
				int r = 0;
				if (pos.y < bounds.from.y) r |= 8;
				if (pos.y > bounds.to.y) r |= 4;
				if (pos.x > bounds.to.x) r |= 2;
				if (pos.x < bounds.from.x) r |= 1;
				return r;
			};

			xy initial_from = from;
			xy initial_to = to;

			int from_flags = get_flags(from);
			int to_flags = get_flags(to);


			while (true) {
				if ((from_flags | to_flags) == 0) return true;
				if (from_flags & to_flags) {
					from = initial_from;
					to = initial_to;
					return false;
				}
				auto visit = [&](int flags) {
					xy pos;
					if (flags & 8) {
						pos.x = from.x + (bounds.from.y - from.y) * (to.x - from.x) / (to.y - from.y);
						pos.y = bounds.from.y;
					}
					else if (flags & 4) {
						pos.x = from.x + (bounds.to.y - from.y) * (to.x - from.x) / (to.y - from.y);
						pos.y = bounds.to.y;
					}
					else if (flags & 2) {
						pos.x = bounds.to.x;
						pos.y = from.y + (bounds.to.x - from.x) * (to.y - from.y) / (to.x - from.x);
					}
					else {
						pos.x = bounds.from.x;
						pos.y = from.y + (bounds.from.x - from.x) * (to.y - from.y) / (to.x - from.x);
					}
					return pos;
				};
				if (from_flags) {
					from = visit(from_flags);
					from_flags = get_flags(from);
				}
				else {
					to = visit(to_flags);
					to_flags = get_flags(to);
				}
			}

		}

		int lcg_rand(int source) {
			// TODO: Handled by Factorio
			return 0;
		}
		int lcg_rand(int source, int from, int to) {
			// TODO: Handled by Factorio
			return from + ((lcg_rand(source) * (to - from + 1)) >> 15);
		}


		std::vector< unit_t*> find_units_noexpand(rect area) const {
			// TODO: Factorio handles unit finder
			return {};
		}


		bool pathfinder_unit_can_collide_with(const unit_t* u, const unit_t* target, const unit_t* consider_collision_with_unit, bool consider_collision_with_moving_units) const {
			if (target != consider_collision_with_unit && !consider_collision_with_moving_units) {
				if (!unit_is_at_move_target(target)) return false;
			}
			if (unit_is_door(target)) return false;
			return unit_can_collide_with(u, target);
		}

		bool is_reachable(xy from, xy to) const {
			// TODO: Refactor this for Factorio mechanics
			return true;
			//return get_region_at(from)->group_index == get_region_at(to)->group_index;
		}

		xy nearest_pos_in_rect(xy pos, rect area) const {
			if (area.from.x > pos.x) pos.x = area.from.x;
			else if (area.to.x < pos.x) pos.x = area.to.x;
			if (area.from.y > pos.y) pos.y = area.from.y;
			else if (area.to.y < pos.y) pos.y = area.to.y;
			return pos;
		}

		bool movement_UM_CheckIllegal(unit_t* u, execute_movement_struct& ems) {
			u_unset_status_flag(u, unit_t::status_flag_collision);
			auto check_illegal = [&]() {
				if (!u_ground_unit(u)) return false;
				bool blocked;
				unit_t* blocking_unit;
				std::tie(blocked, blocking_unit) = is_blocked(u, u->sprite->position);
				if (!blocked) return false;
				if (u_order_not_interruptible(u) || u_iscript_nobrk(u) || u_movement_flag(u, 8)) {
					u_set_status_flag(u, unit_t::status_flag_collision);
					return false;
				}
				xy move_to = u->sprite->position;

				if (unit_type_can_fit_at(u->unit_type, move_to)) {
					if (blocking_unit) {
						check_unit_movement_terrain_collision(u, xy());
						auto find_move_to = [&]() {
							bool other_unit_is_moving = false;
							if (u_can_move(blocking_unit) && (!unit_is_at_move_target(blocking_unit) || blocking_unit->movement_state == movement_states::UM_CheckIllegal || blocking_unit->movement_state == movement_states::UM_MoveToLegal)) {
								other_unit_is_moving = true;
								if (lcg_rand(50, 0, 31) < 24) return;
							}
							else {
								auto super_bb = [&](const unit_t* a, const unit_t* b) {
									rect r = unit_sprite_inner_bounding_box(a);
									r.from.x -= b->unit_type->dimensions.to.x + 1;
									r.from.y -= b->unit_type->dimensions.to.y + 1;
									r.to.x += b->unit_type->dimensions.from.x + 1;
									r.to.y += b->unit_type->dimensions.from.y + 1;
									return r;
								};

								std::array<rect, 4> initial_rects;
								rect initial_rect = super_bb(blocking_unit, u);
								initial_rects.fill(initial_rect);
								initial_rects[0].to.y = initial_rect.from.y;
								initial_rects[1].from.x = initial_rect.to.x;
								initial_rects[2].from.y = initial_rect.to.y;
								initial_rects[3].to.x = initial_rect.from.x;

								auto find_rects = [&](const auto& rects, rect bounds) {
									std::deque<rect> r;
									for (auto v : rects) {
										if (this->get_unique_sided_positions_within_bounds(v.from, v.to, bounds)) {
											r.emplace_back(v.from, v.to);
										}
									}
									return r;
								};

								auto vec = find_rects(initial_rects, u->terrain_no_collision_bounds);

								rect find_bb = initial_rect;
								find_bb.from.x -= u->unit_type->dimensions.from.x;
								find_bb.from.y -= u->unit_type->dimensions.from.y;
								find_bb.to.x += u->unit_type->dimensions.to.x;
								find_bb.to.y += u->unit_type->dimensions.to.y;
								for (const unit_t* n : find_units_noexpand(find_bb)) {
									if (pathfinder_unit_can_collide_with(u, n, nullptr, true)) {
										auto bounds = super_bb(n, u);
										vec = find_rects(vec, bounds);
									}
								}

								xy best_pos = u->sprite->position;
								int best_distance = 9999;
								for (auto& v : vec) {
									xy pos = u->sprite->position;
									if (pos.x > v.to.x) {
										pos.x = v.to.x;
									}
									else if (pos.x < v.from.x) {
										pos.x = v.from.x;
									}
									if (pos.y > v.to.y) {
										pos.y = v.to.y;
									}
									else if (pos.y < v.from.y) {
										pos.y = v.from.y;
									}
									int distance = xy_length(pos - u->sprite->position);
									if (distance < best_distance) {
										best_distance = distance;
										best_pos = pos;
									}
								}
								if (best_distance != 9999) {
									if (unit_type_can_fit_at(u->unit_type, best_pos) && !is_blocked(u, best_pos).first && is_reachable(u->sprite->position, best_pos)) {
										move_to = best_pos;
										return;
									}
								}
							}
							direction_t dir = u->next_velocity_direction + 16_dir * lcg_rand(50, -3, 3);
							fp8 length = fp8::integer(lcg_rand(50, 2, 4) * 4);
							if (!other_unit_is_moving && u_grounded_building(blocking_unit)) length *= 3;
							move_to = u->sprite->position + to_xy(direction_xy(dir, length));
							if (!is_blocked(u, move_to).first && is_reachable(u->sprite->position, move_to)) {
								return;
							}
							if (xy_length(u->move_target.pos - u->sprite->position) <= 32 || lcg_rand(50, 0, 31) >= 24) {
								move_to = u->sprite->position;
								move_to.x += 16 * lcg_rand(50, -2, 2);
								move_to.y += 16 * lcg_rand(50, -2, 2);
							}
							else {
								dir = xy_direction(u->move_target.pos - u->sprite->position) + 16_dir * lcg_rand(50, -1, 1);
								length = fp8::integer(8 + lcg_rand(50, 0, 2) * 4);
								if (!other_unit_is_moving && u_grounded_building(blocking_unit)) length *= 3;
								move_to = u->sprite->position + to_xy(direction_xy(dir, length));
							}
							if (!is_reachable(u->sprite->position, move_to)) {
								move_to = u->sprite->position;
							}
							else {
								auto is_blocked_r = is_blocked(u, move_to);
								if (is_blocked_r.first) {
									if (!is_blocked_r.second) {
										move_to = u->sprite->position;
									}
									else if (other_unit_is_moving && !u_can_move(is_blocked_r.second)) {
										move_to = u->sprite->position;
									}
								}
							}
						};
						find_move_to();
					}
				}
				else {
					direction_t dir = 16_dir * lcg_rand(50, -2, 2);
					fp8 length = fp8::integer(lcg_rand(50, 2, 4) * 8);
					fp8 center_length = 1_fp8;
					if (length > center_length - 1_fp8) length = center_length - 1_fp8;
					move_to = u->sprite->position + to_xy(direction_xy(dir, length));
					if (!is_reachable(u->sprite->position, move_to)) move_to = u->sprite->position;
				}

				if (move_to != u->sprite->position) {
					free_path(u);
					if (unit_is_at_move_target(u) || u->movement_flags & 4) {
						set_unit_move_target(u, move_to);
					}
					else {
						set_next_target_waypoint(u, move_to);
						if (u->next_movement_waypoint != move_to) {
							u->next_movement_waypoint = move_to;
							u_set_movement_flag(u, 1);
						}
					}
					u->path = create_single_step_path(u->sprite->position, move_to);
					u->terrain_no_collision_bounds = {};
					return true;
				}
				else {
					u_set_status_flag(u, unit_t::status_flag_collision);
					return false;
				}
			};
			if (check_illegal()) {
				u->pathing_flags |= 2;
				u->movement_state = movement_states::UM_MoveToLegal;
				return false;
			}
			else {
				u->pathing_flags &= ~(2 | 4);
				if (unit_is_at_move_target(u) || u_movement_flag(u, 4)) {
					u->movement_state = movement_states::UM_AtRest;
				}
				else {
					u->movement_state = movement_states::UM_AnotherPath;
				}
				return true;
			}
		}

		bool movement_UM_Dormant(unit_t* u, execute_movement_struct& ems) {
			bool rest = false;
			if (u_collision(u) && u_ground_unit(u)) rest = true;
			if (!unit_is_at_move_target(u)) rest = true;
			if (u->position != u->next_target_waypoint) rest = true;
			if (rest) {
				u->movement_state = movement_states::UM_AtRest;
				return true;
			}
			return false;
		}

		bool movement_UM_Turret(unit_t* u, execute_movement_struct& ems) {
			//ems.refresh_vision = false;
			set_unit_move_target(u, u->sprite->position);
			auto dir_error = u->desired_velocity_direction - u->heading;
			if (dir_error != -128_dir) {
				if (dir_error >= -10_dir && dir_error <= 10_dir) {
					u_unset_movement_flag(u, 1);
				}
			}
			if (u_status_flag(u, (unit_t::status_flags_t)0x2000000)) {
				set_movement_flags(u, ems);
			}
			else {
				update_current_velocity_direction_towards_waypoint(u);
				set_movement_flags(u, ems);
				update_unit_heading(u, u->current_velocity_direction);
			}
			return false;
		}

		bool ut_building(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_building);
		}

		direction_t direction_from_index(size_t index) const {
			int v = (int)index;
			if (v >= 128) v = -(256 - v);
			return direction_t::from_raw(v);
		}

		rect unit_sprite_bounding_box(const unit_t* u) const {
			return { u->sprite->position - u->unit_type->dimensions.from, u->sprite->position + u->unit_type->dimensions.to + xy(1, 1) };
		}

		void update_repulse_direction(unit_t* u) {
			direction_t repulse_dir = u->repulse_direction;
			if (!unit_is_at_move_target(u)) {
				direction_t target_dir = xy_direction(u->move_target.pos - u->position);
				size_t index = direction_index(repulse_dir - target_dir);
				repulse_dir = target_dir + direction_from_index(index % 32 + (index < 128 ? 32 : -64));
			}
			u->repulse_direction = repulse_dir;
		}
		bool apply_repulse_field(unit_t* u, execute_movement_struct& ems) {
			if (!u_can_move(u)) return false;
			if (ut_building(u)) return false;
			if (unit_is(u, UnitTypes::Protoss_Interceptor)) return false;
			if (u_order_not_interruptible(u)) return false;
			if (u_iscript_nobrk(u)) return false;
			int strength = st.repulse_field[u->repulse_index];
			if (strength <= 1) {
				u->repulse_flags &= ~7;
				return false;
			}
			if (u->repulse_flags & 7) {
				--u->repulse_flags;
			}
			else {
				u->repulse_flags |= 7;
				update_repulse_direction(u);
			}
			xy_fp8 repulse = direction_xy(u->repulse_direction) / 2;
			if (unit_is_at_move_target(u)) {
				repulse *= strength / 4 + 1;
				repulse /= 2;
			}
			size_t index = u->repulse_flags >> 4;
			xy_fp8 adjust = { fp8::from_raw(repulse_adjust_table[index * 2]), fp8::from_raw(repulse_adjust_table[index * 2 + 1]) };
			if (repulse.x > adjust.x * 4) repulse.x -= adjust.x;
			else if (repulse.x > 0_fp8) repulse.x += adjust.x;
			else if (repulse.x < -adjust.x * 4) repulse.x += adjust.x;
			else if (repulse.x < 0_fp8) repulse.x -= adjust.x;
			if (repulse.y > adjust.y * 4) repulse.y -= adjust.y;
			else if (repulse.y > 0_fp8) repulse.y += adjust.y;
			else if (repulse.y < -adjust.y * 4) repulse.y += adjust.y;
			else if (repulse.y < 0_fp8) repulse.y -= adjust.y;
			ems.exact_position += repulse;
			ems.position = to_xy(ems.exact_position);
			return true;
		}

		size_t repulse_index(xy pos) {
			size_t ux = pos.x;
			size_t uy = pos.y;
			ux /= 48;
			uy /= 48;
			return uy * game_st.repulse_field_width + ux;
		}

		void increment_repulse_field(unit_t* u) {
			if (!u_can_move(u)) return;
			if (ut_building(u)) return;
			if (unit_is(u, UnitTypes::Protoss_Interceptor)) return;
			if ((u->repulse_flags & 0xf0) == 0) {
				unsigned int v = lcg_rand(37);
				u->repulse_direction = direction_from_index(v & 0xff);
				v = (v >> 8) & 0xf0;
				if (v == 0) v = 0xf0;
				u->repulse_flags = v;
			}
			u->repulse_flags &= ~7;
			u->repulse_index = repulse_index(u->sprite->position);
			auto& v = st.repulse_field.at(u->repulse_index);
			if (v < 0xff) ++v;
		}

		void decrement_repulse_field(unit_t* u) {
			if (!u_can_move(u)) return;
			if (ut_building(u)) return;
			if (unit_is(u, UnitTypes::Protoss_Interceptor)) return;
			auto& v = st.repulse_field.at(u->repulse_index);
			if (v > 0) --v;
		}

		bool movement_UM_Flyer(unit_t* u, execute_movement_struct& ems) {
			if (u->sprite->position != u->move_target.pos) {
				xy move_target = u->move_target.pos;
				if (move_target != u->move_target.pos) {
					set_flingy_move_target(u, move_target);
					u_set_status_flag(u, unit_t::status_flag_immovable);
				}
			}
			update_unit_movement_values(u, ems);
			bool being_repulsed = apply_repulse_field(u, ems);
			finish_unit_movement(u, ems);
			if (u_can_move(u) && !ut_building(u) && u->unit_type->id != UnitTypes::Protoss_Interceptor) {
				size_t index = repulse_index(u->position);
				if (index != u->repulse_index) {
					decrement_repulse_field(u);
					increment_repulse_field(u);
				}
				if (being_repulsed) {
					if (std::max(std::abs(u->move_target.pos.x - u->position.x), std::abs(u->move_target.pos.y - u->position.y)) < 24) {
						u->move_target.pos = u->position;
						u->next_movement_waypoint = u->position;
					}
				}
			}
			return false;
		}

		bool movement_UM_AnotherPath(unit_t* u, execute_movement_struct& ems) {
			if (unit_path_to(u, u->move_target.pos, st.consider_collision_with_unit_bug)) u->movement_state = movement_states::UM_FollowPath;
			else u->movement_state = movement_states::UM_FailedPath;
			return false;
		}

		bool movement_UM_StartPath(unit_t* u, execute_movement_struct& ems) {
			if (unit_path_to(u, u->move_target.pos, st.consider_collision_with_unit_bug)) {
				auto next_movement_state = movement_states::UM_FollowPath;
				u->movement_state = next_movement_state;
				return true;
			}
			else {
				u->movement_state = movement_states::UM_FailedPath;
				return false;
			}
		}

		unit_id get_unit_id(const unit_t* u) const {
			if (!u) return unit_id{};
			return unit_id(u->index + 1, u->unit_id_generation % (1u << 5));
		}

		bool movement_UM_FollowPath(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, true)) return true;
			if (!unit_path_to(u, u->move_target.pos, st.consider_collision_with_unit_bug)) {
				u->movement_state = movement_states::UM_AnotherPath;
				return true;
			}
			fp8 speed = u->next_speed;
			update_unit_movement_values(u, ems);
			if (u->flingy_movement_type == 0) speed = u->current_speed;
			const unit_t* collision_unit = nullptr;
			collision_unit = check_ground_unit_movement_unit_collision(u, ems);
			if (collision_unit) {
				bool fix_collision = false;
				if (check_unit_movement_terrain_collision(u, ems)) fix_collision = true;
				else if (u->velocity.x < 32_fp8 && u->velocity.y < 32_fp8) fix_collision = true;
				else if (ems.speed != u->current_speed) fix_collision = true;
				else {
					auto pos = ems.position;
					auto exact_pos = ems.exact_position;
					ems.exact_position = u->exact_position + u->velocity / 2;
					ems.position = to_xy(ems.exact_position);
					if (check_unit_movement_unit_collision(u, ems)) {
						ems.exact_position = u->exact_position + u->velocity / 4;
						ems.position = to_xy(ems.exact_position);
						if (check_unit_movement_unit_collision(u, ems)) {
							ems.position = pos;
							ems.exact_position = exact_pos;
							fix_collision = true;
						}
					}
				}
				if (fix_collision) {
					u->path->last_collision_unit = get_unit_id(collision_unit);
					u->path->last_collision_speed = speed;
					u->movement_state = movement_states::UM_FixCollision;
					return true;
				}
			}
			else {
				if (check_unit_movement_terrain_collision(u, ems)) {
					u->path->last_collision_speed = speed;
					u->movement_state = movement_states::UM_FixTerrain;
					return true;
				}
			}
			if (u->sprite->position != ems.position) {
				if (u->pathing_collision_counter) {
					if (u->pathing_collision_counter > 2) u->pathing_collision_counter = 2;
					else --u->pathing_collision_counter;
				}
			}
			finish_unit_movement(u, ems);
			if (unit_is_at_move_target(u)) {
				u->movement_state = movement_states::UM_AtMoveTarget;
			}
			else {
				if (u->path) {
					if (u->path->delay) --u->path->delay;
					else {
						u->path->delay = 30;
						u->movement_state = movement_states::UM_ScoutPath;
					}
				}
			}
			return false;
		}

		bool movement_UM_ScoutPath(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, true)) return true;

			u->movement_state = movement_states::UM_FollowPath;
			return true;
		}

		bool movement_UM_AtMoveTarget(unit_t* u, execute_movement_struct& ems) {
			free_path(u);
			if (u->next_movement_waypoint != u->move_target.pos) u->next_movement_waypoint = u->move_target.pos;
			if (!u_ground_unit(u) || u_movement_flag(u, 4)) {
				u->movement_state = movement_states::UM_AtRest;
			}
			else {
				u->movement_state = movement_states::UM_CheckIllegal;
			}
			return true;
		}

		bool movement_UM_NewMoveTarget(unit_t* u, execute_movement_struct& ems) {
			u->path->state_flags &= ~1;
			if (!unit_update_path_movement_state(u, true)) {
				free_path(u);
				u->movement_state = movement_states::UM_Repath;
			}
			return true;
		}

		unit_t* get_unit(unit_id id) const {
			return nullptr;
		}

		bool movement_UM_Repath(unit_t* u, execute_movement_struct& ems) {
			const unit_t* collision_unit = st.consider_collision_with_unit_bug;
			if (u->path) {
				collision_unit = get_unit(u->path->last_collision_unit);
				free_path(u);
			}
			st.consider_collision_with_unit_bug = nullptr;
			if (unit_path_to(u, u->move_target.pos, collision_unit)) u->movement_state = movement_states::UM_FollowPath;
			else u->movement_state = movement_states::UM_FailedPath;
			return true;
		}

		bool movement_UM_FixTerrain(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_update_path_movement_state(u, true)) return true;
			set_next_speed(u, u->path->last_collision_speed);
			update_unit_movement_values(u, ems);
			if (check_unit_movement_terrain_collision(u, ems) || check_unit_movement_unit_collision(u, ems)) {
				update_unit_pathing_collision(u);
				if (u->next_velocity_direction == xy_direction(u->next_movement_waypoint - u->sprite->position)) {
					direction_t slide_free_direction = -1_dir;
					xy movement = ems.position - u->sprite->position;
					auto desired_quadrant = direction_index(u->current_velocity_direction) / 64;
					if (ems.position.x != u->sprite->position.x && (ems.position.y == u->sprite->position.y || check_unit_movement_terrain_collision(u, xy{ movement.x, 0 }))) {
						if (movement.x >= 0) {
							if (desired_quadrant == 0) slide_free_direction = 0_dir;
							if (desired_quadrant == 1) slide_free_direction = -128_dir;
						}
						else {
							if (desired_quadrant == 3) slide_free_direction = 0_dir;
							if (desired_quadrant == 2) slide_free_direction = -128_dir;
						}
					}
					else {
						if (movement.y < 0) {
							if (desired_quadrant == 0) slide_free_direction = 64_dir;
							if (desired_quadrant == 3) slide_free_direction = -64_dir;
						}
						else {
							if (desired_quadrant == 1) slide_free_direction = 64_dir;
							if (desired_quadrant == 2) slide_free_direction = -64_dir;
						}
					}
					u->path->slide_free_direction = slide_free_direction;

					u->movement_state = movement_states::UM_TerrainSlide;
				}
				else {
					update_unit_heading(u, u->current_velocity_direction);
				}
			}
			else {
				finish_unit_movement(u, ems);
				u->movement_flags |= 1;
				u->movement_state = movement_states::UM_FollowPath;
			}
			return false;
		}

		bool movement_UM_FailedPath(unit_t* u, execute_movement_struct& ems) {
			u->pathing_collision_counter = 10;
			update_unit_pathing_collision(u);
			u->movement_state = movement_states::UM_RetryPath;
			return false;
		}

		bool movement_UM_TerrainSlide(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_update_path_movement_state(u, true)) return true;
			auto move = [&](direction_t direction) {
				ems.pre_movement_flags = u->movement_flags;
				set_current_velocity_direction(u, direction);
				update_current_speed_towards_waypoint(u);
				set_movement_flags(u, ems);
				set_movement_values(u, ems);
				ems.post_movement_flags = u->movement_flags;
				u->movement_flags = ems.pre_movement_flags;
			};
			u->movement_flags &= ~1;
			auto next_velocity_direction = u->next_velocity_direction;
			move(u->path->slide_free_direction);
			u->movement_flags |= 1;
			u->next_velocity_direction = next_velocity_direction;
			set_desired_velocity_direction(u, u->path->slide_free_direction);
			if (check_unit_movement_unit_collision(u, ems) || check_unit_movement_terrain_collision(u, ems)) {
				u->movement_state = movement_states::UM_ForceMoveFree;
			}
			else {
				finish_unit_movement(u, ems);
				auto next_speed = u->next_speed;
				set_next_speed(u, u->path->last_collision_speed);
				move(xy_direction(u->next_movement_waypoint - u->sprite->position));
				set_next_speed(u, next_speed);
				if (!check_unit_movement_terrain_collision(u, ems)) {
					u->movement_flags |= 1;
					u->movement_state = movement_states::UM_FollowPath;
				}
			}
			return false;
		}

		bool movement_UM_TurnAndStart(unit_t* u, execute_movement_struct& ems) {
			const unit_t* collision_unit = st.consider_collision_with_unit_bug;
			if (u->path) {
				collision_unit = get_unit(u->path->last_collision_unit);
				free_path(u);
				st.consider_collision_with_unit_bug = collision_unit;
			}
			if (unit_is_at_move_target(u) || u->movement_flags & 4) {
				u->movement_state = movement_states::UM_AtMoveTarget;
				return true;
			}
			st.consider_collision_with_unit_bug = nullptr;
			if (unit_path_to(u, u->move_target.pos, collision_unit)) {
				u->movement_state = movement_states::UM_FaceTarget;
				return false;
			}
			else {
				u->movement_state = movement_states::UM_FailedPath;
				return true;
			}
		}

		bool movement_UM_FaceTarget(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, true)) return true;
			if (unit_is_at_move_target(u) || u->movement_flags & 4) {
				u->movement_state = movement_states::UM_AtMoveTarget;
				return true;
			}
			if (u->next_velocity_direction == xy_direction(u->next_movement_waypoint - u->sprite->position)) {
				if (u->path->state_flags & 1) u->movement_state = movement_states::UM_NewMoveTarget;
				else u->movement_state = movement_states::UM_FollowPath;
				return true;
			}
			else {
				update_unit_movement_values(u, ems);
				update_unit_heading(u, u->current_velocity_direction);
				return false;
			}
		}

		bool movement_UM_RetryPath(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, false)) return true;
			if (u->pathing_collision_counter < 20) {
				++u->pathing_collision_counter;
				return false;
			}
			if (unit_path_to(u, u->move_target.pos, st.consider_collision_with_unit_bug)) {
				u->movement_state = movement_states::UM_FollowPath;
				return true;
			}
			set_unit_immovable(u);
			u->movement_state = movement_states::UM_AtMoveTarget;
			return false;
		}

		bool movement_UM_InitSeq(unit_t* u, execute_movement_struct& ems) {
			if (u_status_flag(u, unit_t::status_flag_iscript_nobrk)) return false;
			u->movement_state = movement_states::UM_Init;
			return true;
		}

		bool movement_UM_ForceMoveFree(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_is_at_move_target(u) || u_movement_flag(u, 4)) {
				u->movement_state = movement_states::UM_AtMoveTarget;
				return false;
			}
			set_next_speed(u, 0_fp8);
			free_path(u);
			u->movement_state = movement_states::UM_TurnAndStart;
			return true;
		}

		bool is_intersecting(rect a, rect b) const {
			if (b.from.x > a.to.x) return false;
			if (b.from.y > a.to.y) return false;
			if (a.from.x > b.to.x) return false;
			if (a.from.y > b.to.y) return false;
			return true;
		}
		const unit_t* unit_main_unit(const unit_t* u) const {
			return ut_turret(u) ? u->subunit : u;
		}


		bool movement_UM_FixCollision(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, false)) return true;
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			const unit_t* collision_unit = get_unit(u->path->last_collision_unit);
			if (!collision_unit || us_hidden(collision_unit) || !unit_can_collide_with(u, collision_unit)) {
				u->movement_state = movement_states::UM_FollowPath;
				return false;
			}
			direction_t slide_free_direction;
			int state = 1;
			if (!u->move_target.unit || !is_intersecting(unit_sprite_bounding_box(unit_main_unit(u)), unit_sprite_bounding_box(u->move_target.unit))) {
				if (is_intersecting(unit_sprite_inner_bounding_box(collision_unit), unit_inner_bounding_box(u, u->move_target.pos))) {
					if (collision_unit->pathing_collision_counter >= 30) state = u->move_target.unit ? 3 : 2;
					else if (is_intersecting(unit_inner_bounding_box(collision_unit, collision_unit->move_target.pos), unit_inner_bounding_box(u, u->move_target.pos))) {
						state = u->move_target.unit ? 3 : 2;
					}
				}
				else {
					if (!is_intersecting(unit_sprite_inner_bounding_box(collision_unit), unit_inner_bounding_box(u, u->next_movement_waypoint))) {
						if (u_movement_flag(collision_unit, 2)) {
							auto index = direction_index(collision_unit->next_velocity_direction);
							switch (cardinal_direction_from_to(u, collision_unit)) {
							case 0:
								if (index <= 64 || index >= 192) state = 6;
								break;
							case 1:
								if (index <= 128) state = 6;
								break;
							case 2:
								if (index >= 64 && index <= 192) state = 6;
								break;
							case 3:
								if (index == 0 || index >= 128) state = 6;
								break;
							}
							if (state == 1) {
								if (collision_unit->pathing_collision_counter <= 2) {
									if (!unit_is_at_move_target(collision_unit)) {
										if (collision_unit->movement_state == movement_states::UM_FollowPath || collision_unit->movement_state == movement_states::UM_ScoutPath) {
											state = 6;
										}
										else if (collision_unit->movement_state != movement_states::UM_WaitFree) {
											state = 4;
										}
									}
								}
							}
						}
						if (state == 1) {
							if (collision_get_slide_free_direction(u, collision_unit, slide_free_direction)) state = 7;
							else state = 5;
						}
					}
					if (state == 1) {
						if (collision_unit->pathing_collision_counter >= 30) state = 3;
						else if (is_intersecting(unit_inner_bounding_box(collision_unit, collision_unit->move_target.pos), unit_inner_bounding_box(u, u->next_movement_waypoint))) {
							state = 3;
						}
					}
				}
				if (state == 1) {
					direction_t collision_dir = xy_direction(collision_unit->sprite->position - u->sprite->position);
					direction_t cmp_dir = 0_dir;
					auto index = direction_index(collision_unit->next_velocity_direction);
					if (index < 32) cmp_dir = 0_dir;
					else if (index < 96) cmp_dir = 64_dir;
					else if (index < 160) cmp_dir = -128_dir;
					else if (index < 224) cmp_dir = -64_dir;
					if (fp8::extend(cmp_dir - collision_dir).abs() > 64_fp8) {
						state = 4;
					}
					else {
						state = 6;
					}
				}
			}
			if (st.current_frame - u->path->creation_frame >= 7 || state < 3 || state > 5) {
				switch (state) {
				case 1:
					set_unit_immovable(u);
					u_unset_status_flag(u, unit_t::status_flag_immovable);
					u->movement_state = movement_states::UM_AtMoveTarget;
					break;
				case 2:
					set_unit_immovable(u);
					u->movement_state = movement_states::UM_AtMoveTarget;
					break;
				case 3:
					u->movement_state = movement_states::UM_Repath;
					break;
				case 4:
					u->movement_state = movement_states::UM_RepathMovers;
					break;
				case 5:
					u->movement_state = movement_states::UM_TurnAndStart;
					set_next_speed(u, 0_fp8);
					break;
				case 6:
					u->movement_state = movement_states::UM_WaitFree;
					break;
				case 7:
					u->path->slide_free_direction = slide_free_direction;
					u->movement_state = movement_states::UM_SlidePrep;
					break;
				case 8:
					u->movement_state = movement_states::UM_GetFree;
					break;
				}
			}
			else {
				update_unit_pathing_collision(u);
			}
			return false;
		}

		bool movement_UM_WaitFree(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_update_path_movement_state(u, true)) return true;
			set_next_speed(u, u->path->last_collision_speed);
			update_unit_movement_values(u, ems);
			if (check_unit_movement_unit_collision(u, ems)) {
				update_unit_pathing_collision(u);
				set_next_speed(u, 0_fp8);
				if (u->next_velocity_direction != xy_direction(u->next_movement_waypoint - u->sprite->position)) {
					update_unit_heading(u, u->current_velocity_direction);
				}
				if (u->pathing_collision_counter >= 25) {
					if (lcg_rand(51) < 0x7fff / 2) {
						u->movement_state = movement_states::UM_ForceMoveFree;
					}
					else {
						u->movement_state = movement_states::UM_RepathMovers;
					}
				}
			}
			else {
				if (check_unit_movement_terrain_collision(u, ems)) {
					u->movement_state = movement_states::UM_Repath;
				}
				else {
					finish_unit_movement(u, ems);
					u->movement_state = movement_states::UM_FollowPath;
				}
			}
			return false;
		}

		bool movement_UM_SlidePrep(unit_t* u, execute_movement_struct& ems) {
			if (unit_update_path_movement_state(u, true)) return true;
			if (u->flingy_movement_type == 0) {
				if (u->path->last_collision_speed >= fp8::integer(2)) u->path->last_collision_speed /= 2;
				else if (u->path->last_collision_speed > fp8::integer(1)) u->path->last_collision_speed = fp8::integer(1);
			}
			set_current_velocity_direction(u, u->next_velocity_direction);
			set_next_speed(u, u->path->last_collision_speed);
			u->movement_state = movement_states::UM_SlideFree;
			return true;
		}

		bool movement_UM_SlideFree(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_update_path_movement_state(u, true)) return true;
			u->movement_flags |= 1;
			set_desired_velocity_direction(u, u->path->slide_free_direction);
			update_unit_heading(u, u->current_velocity_direction);
			if (u->flingy_movement_type == 2) u->current_speed = u->flingy_top_speed;
			else update_current_speed_towards_waypoint(u);

			auto move = [&]() {
				ems.pre_movement_flags = u->movement_flags;
				set_movement_flags(u, ems);
				set_movement_values(u, ems);
				ems.post_movement_flags = u->movement_flags;
				u->movement_flags = ems.pre_movement_flags;
			};

			fp8 original_speed = u->current_speed;
			auto original_velocity_direction = u->next_velocity_direction;
			const unit_t* collision_unit = get_unit(u->path->last_collision_unit);
			const unit_t* next_collision_unit = nullptr;
			bool force_move_free = false;
			for (fp8 speed = original_speed; speed > 0_fp8; speed -= fp8::integer(1)) {
				u_unset_movement_flag(u, 1);
				set_current_velocity_direction(u, u->path->slide_free_direction);
				set_next_speed(u, std::min(speed, fp8::integer(1)));
				move();
				if (check_unit_movement_unit_collision(u, ems) || check_unit_movement_terrain_collision(u, ems)) {
					force_move_free = true;
					break;
				}
				finish_unit_movement(u, ems);
				u->next_velocity_direction = original_velocity_direction;
				update_current_velocity_direction_towards_waypoint(u);
				set_next_speed(u, original_speed);
				move();
				next_collision_unit = check_unit_movement_unit_collision(u, ems);
				if (next_collision_unit != collision_unit) break;
			}
			u->next_velocity_direction = original_velocity_direction;
			set_current_velocity_direction(u, u->next_velocity_direction);
			set_next_speed(u, original_speed);
			if (force_move_free) {
				u->movement_state = movement_states::UM_ForceMoveFree;
				return false;
			}
			if (!next_collision_unit) {
				u_set_movement_flag(u, 1);
				if (st.current_frame - u->path->creation_frame < 150) {
					u->movement_state = movement_states::UM_FollowPath;
				}
				else {
					u->movement_state = movement_states::UM_TurnAndStart;
				}
			}
			return false;
		}

		bool movement_UM_RepathMovers(unit_t* u, execute_movement_struct& ems) {
			free_path(u);
			auto move_target = u->move_target;
			if (!unit_path_to(u, move_target.pos, st.consider_collision_with_unit_bug, true) || u_immovable(u)) {
				u->move_target = move_target;
				u->movement_state = movement_states::UM_TurnAndStart;
				return false;
			}
			else {
				u->movement_state = movement_states::UM_FaceTarget;
				return true;
			}
		}

		bool movement_UM_GetFree(unit_t* u, execute_movement_struct& ems) {
			if (u->pathing_collision_counter < 255) ++u->pathing_collision_counter;
			if (unit_update_path_movement_state(u, true)) return true;
			set_next_speed(u, u->path->last_collision_speed);
			update_unit_movement_values(u, ems);
			const unit_t* collision_unit = check_unit_movement_unit_collision(u, ems);
			if (collision_unit) {
				if (u->next_velocity_direction == xy_direction(u->next_movement_waypoint - u->sprite->position)) {
					free_path(u);
				}
			}
			else {
				if (check_unit_movement_terrain_collision(u, ems)) {
					u->movement_state = movement_states::UM_Repath;
				}
				else {
					finish_unit_movement(u, ems);
					u->movement_state = movement_states::UM_FollowPath;
				}
			}
			return false;
		}

		bool movement_UM_Lump(unit_t* u, execute_movement_struct& ems) {
			return false;
		}

		std::vector< unit_t*> find_units(rect area) const {
			// TODO: Factorio handles unit finder
			return {};
		}

		bool unit_finder_units_intersecting(unit_t* a, unit_t* b) const {
			return is_intersecting(a->unit_finder_bounding_box, b->unit_finder_bounding_box);
		}

		bool u_flying(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_flying);
		}
		void check_unit_collision(unit_t* u) {
			for (unit_t* nu : find_units(unit_sprite_inner_bounding_box(u))) {
				if (u_grounded_building(nu)) {
					u_set_status_flag(u, unit_t::status_flag_collision);
				}
				else if (!u_flying(nu) && (!u_gathering(nu) || u_grounded_building(u))) {
					if (unit_finder_units_intersecting(u, nu)) {
						u_set_status_flag(nu, unit_t::status_flag_collision);
					}
				}
			}
		}

		bool movement_UM_MoveToLegal(unit_t* u, execute_movement_struct& ems) {
			if (!u->path) {
				u->movement_state = movement_states::UM_CheckIllegal;
				return true;
			}

			auto move = [&]() {
				if (!is_moving_along_path(u)) return true;
				update_unit_movement_values(u, ems);
				finish_unit_movement(u, ems);
				return false;
			};

			if (u->pathing_flags & 4) {
				u->pathing_flags &= ~4;
				u_set_status_flag(u, unit_t::status_flag_collision);
				free_path(u);
				u->movement_state = movement_states::UM_AtRest;
				return true;
			}
			else {
				if (u->path->state_flags & 1 || u->path->next != u->next_movement_waypoint) {
					u->next_movement_waypoint = u->path->next;
				}
				if (move()) {
					free_path(u);
					check_unit_collision(u);
					u_set_status_flag(u, unit_t::status_flag_collision);
					u->movement_state = movement_states::UM_CheckIllegal;
				}
				return false;
			}
		}

		bool movement_UM_Hidden(unit_t* u, execute_movement_struct& ems) {
			//ems.refresh_vision = false;
			return false;
		}

		bool movement_UM_Bunker(unit_t* u, execute_movement_struct& ems) {
			//ems.refresh_vision = false;
			update_current_velocity_direction_towards_waypoint(u);
			set_movement_flags(u, ems);
			update_unit_heading(u, u->current_velocity_direction);
			return false;
		}

		bool movement_UM_LumpWannabe(unit_t* u, execute_movement_struct& ems) {
			if (!unit_is_at_move_target(u) || u_movement_flag(u, 2)) {
				update_unit_movement_values(u, ems);
				if (check_ground_unit_movement_unit_collision(u, ems) || check_unit_movement_terrain_collision(u, ems)) {
					set_next_speed(u, 0_fp8);
					u->movement_flags = ems.post_movement_flags;
					update_unit_heading(u, u->current_velocity_direction);
					if (ems.stopping_movement) {
						if (!s_flag(u->sprite, sprite_t::flag_iscript_nobrk)) {
							sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
						}
					}
					else if (ems.starting_movement) {
						sprite_run_anim(u->sprite, iscript_anims::Walking);
					}

					set_flingy_move_target(u, u->sprite->position);
					stop_unit(u);
				}
				else {
					finish_unit_movement(u, ems);
				}
				return false;
			}
			else {
				u->movement_state = movement_states::UM_Lump;
				return true;
			}
		}

		bool movement_UM_BldgTurret(unit_t* u, execute_movement_struct& ems) {
			update_current_velocity_direction_towards_waypoint(u);
			set_movement_flags(u, ems);
			update_unit_heading(u, u->current_velocity_direction);
			return false;
		}

		void execute_movement(unit_t* u) {
			execute_movement_struct ems;

			while (true) {
				bool cont = false;
				switch (u->movement_state) {
				case movement_states::UM_Init:
					cont = movement_UM_Init(u, ems);
					break;
				case movement_states::UM_InitSeq:
					cont = movement_UM_InitSeq(u, ems);
					break;
				case movement_states::UM_Lump:
					cont = movement_UM_Lump(u, ems);
					break;
				case movement_states::UM_Turret:
					cont = movement_UM_Turret(u, ems);
					break;
				case movement_states::UM_Bunker:
					cont = movement_UM_Bunker(u, ems);
					break;
				case movement_states::UM_BldgTurret:
					cont = movement_UM_BldgTurret(u, ems);
					break;
				case movement_states::UM_Hidden:
					cont = movement_UM_Hidden(u, ems);
					break;
				case movement_states::UM_Flyer:
					cont = movement_UM_Flyer(u, ems);
					break;

				case movement_states::UM_AtRest:
					cont = movement_UM_AtRest(u, ems);
					break;
				case movement_states::UM_Dormant:
					cont = movement_UM_Dormant(u, ems);
					break;
				case movement_states::UM_AtMoveTarget:
					cont = movement_UM_AtMoveTarget(u, ems);
					break;
				case movement_states::UM_CheckIllegal:
					cont = movement_UM_CheckIllegal(u, ems);
					break;
				case movement_states::UM_MoveToLegal:
					cont = movement_UM_MoveToLegal(u, ems);
					break;
				case movement_states::UM_LumpWannabe:
					cont = movement_UM_LumpWannabe(u, ems);
					break;
				case movement_states::UM_FailedPath:
					cont = movement_UM_FailedPath(u, ems);
					break;
				case movement_states::UM_RetryPath:
					cont = movement_UM_RetryPath(u, ems);
					break;
				case movement_states::UM_StartPath:
					cont = movement_UM_StartPath(u, ems);
					break;
				case movement_states::UM_TurnAndStart:
					cont = movement_UM_TurnAndStart(u, ems);
					break;
				case movement_states::UM_FaceTarget:
					cont = movement_UM_FaceTarget(u, ems);
					break;
				case movement_states::UM_NewMoveTarget:
					cont = movement_UM_NewMoveTarget(u, ems);
					break;
				case movement_states::UM_AnotherPath:
					cont = movement_UM_AnotherPath(u, ems);
					break;
				case movement_states::UM_Repath:
					cont = movement_UM_Repath(u, ems);
					break;
				case movement_states::UM_RepathMovers:
					cont = movement_UM_RepathMovers(u, ems);
					break;
				case movement_states::UM_FollowPath:
					cont = movement_UM_FollowPath(u, ems);
					break;
				case movement_states::UM_ScoutPath:
					cont = movement_UM_ScoutPath(u, ems);
					break;
				case movement_states::UM_FixCollision:
					cont = movement_UM_FixCollision(u, ems);
					break;
				case movement_states::UM_WaitFree:
					cont = movement_UM_WaitFree(u, ems);
					break;
				case movement_states::UM_GetFree:
					cont = movement_UM_GetFree(u, ems);
					break;
				case movement_states::UM_SlidePrep:
					cont = movement_UM_SlidePrep(u, ems);
					break;
				case movement_states::UM_SlideFree:
					cont = movement_UM_SlideFree(u, ems);
					break;
				case movement_states::UM_ForceMoveFree:
					cont = movement_UM_ForceMoveFree(u, ems);
					break;
				case movement_states::UM_FixTerrain:
					cont = movement_UM_FixTerrain(u, ems);
					break;
				case movement_states::UM_TerrainSlide:
					cont = movement_UM_TerrainSlide(u, ems);
					break;
				}
				if (!cont) break;
			}
		}

		bool u_completed(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_completed);
		}

		bool ut_invincible(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_invincible);
		}

		bool u_disabled(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_disabled);
		}
		bool unit_is_disabled(const unit_t* u) const {
			if (u_disabled(u)) return true;
			if (u->lockdown_timer) return true;
			if (u->stasis_timer) return true;
			if (u->maelstrom_timer) return true;
			return false;
		}

		order_t* create_order(const order_type_t* order_type, order_target_t target) {
			order_t* o = st.orders_container.top();
			if (!o) return nullptr;
			st.orders_container.pop();
			++st.active_orders_size;
			o->order_type = order_type;
			o->target = target;
			return o;
		}

		void queue_order(intrusive_list<order_t, default_link_f>::iterator pos, unit_t* u, const order_type_t* order_type, order_target_t target) {
			order_t* o = create_order(order_type, target);
			if (!o) {
				return;
			}
			if (o->order_type->highlight != -1) ++u->order_queue_count;
			u->order_queue.insert(pos, *o);
		}

		void remove_queued_order(unit_t* u, order_t* o) {
			if (o->order_type->highlight != -1) --u->order_queue_count;
			if (u->order_queue_count == -1) u->order_queue_count = 0;
			u->order_queue.remove(*o);
			st.orders_container.push(o);
			--st.active_orders_size;
		}
		void queue_order_back(unit_t* u, const order_type_t* order_type, order_target_t target) {
			queue_order(u->order_queue.end(), u, order_type, target);
		}

		void set_queued_order(unit_t* u, bool interrupt, const order_type_t* order_type, order_target_t target) {
			if (u->order_type->id == Orders::Die) return;
			while (!u->order_queue.empty()) {
				order_t* o = &u->order_queue.back();
				if (!o) break;
				if ((!interrupt || !o->order_type->can_be_interrupted) && o->order_type != order_type) break;
				remove_queued_order(u, o);
			}
			if (order_type->id != Orders::Cloak) {
				queue_order_back(u, order_type, target);
			}
		}

		template<typename T>
		struct thingy_setter {
			T& thingy;
			T prev_thingy;
			thingy_setter(T& thingy, T new_thingy) : thingy(thingy) {
				prev_thingy = std::move(thingy);
				thingy = std::move(new_thingy);
			}
			~thingy_setter() {
				thingy = std::move(prev_thingy);
			}
		};
		template<typename T, typename T2>
		auto make_thingy_setter(T& thingy, T2&& new_thingy) {
			return thingy_setter<T>(thingy, std::forward<T2>(new_thingy));
		}
		void iscript_run_to_idle(unit_t* u) {
			u->status_flags &= ~unit_t::status_flag_iscript_nobrk;
			u->sprite->flags &= ~sprite_t::flag_iscript_nobrk;
			auto ius = make_thingy_setter(iscript_unit, u);
			auto ifs = make_thingy_setter(iscript_flingy, u);
			int anim = -1;
			auto sid = u->sprite->sprite_type->id;
			// TODO: iscript in Factorio
			switch (0) {
			case iscript_anims::AirAttkInit:
			case iscript_anims::AirAttkRpt:
				anim = iscript_anims::AirAttkToIdle;
				break;
			case iscript_anims::AlmostBuilt:
				if (sid == SpriteTypes::SPRITEID_SCV || sid == SpriteTypes::SPRITEID_Drone || sid == SpriteTypes::SPRITEID_Probe) {
					anim = iscript_anims::GndAttkToIdle;
				}
				break;
			case iscript_anims::GndAttkInit:
			case iscript_anims::GndAttkRpt:
				anim = iscript_anims::GndAttkToIdle;
				break;
			case iscript_anims::SpecialState1:
				if (sid == SpriteTypes::SPRITEID_Medic) anim = iscript_anims::WalkingToIdle;
				break;
			case iscript_anims::CastSpell:
				anim = iscript_anims::WalkingToIdle;
				break;
			}
			if (anim != -1) {
				sprite_run_anim(u->sprite, anim);
			}
			u_unset_movement_flag(u, 8);
		}

		void set_unit_order(unit_t* u, const order_type_t* order_type) {
			set_queued_order(u, true, order_type, order_target_t{});
			activate_next_order(u);
		}

		void set_unit_order(unit_t* u, const order_type_t* order_type, order_target_t target) {
			set_queued_order(u, true, order_type, target);
			activate_next_order(u);
		}

		void set_unit_order(unit_t* u, const order_type_t* order_type, unit_t* target_unit) {
			order_target_t target;
			target.unit = target_unit;
			if (target_unit) {
				target.position = target_unit->sprite->position;
			}
			set_queued_order(u, true, order_type, target);
			activate_next_order(u);
		}

		void set_unit_order(unit_t* u, const order_type_t* order_type, xy position) {
			order_target_t target;
			target.position = position;
			set_queued_order(u, true, order_type, target);
			activate_next_order(u);
		}

		void activate_next_order(unit_t* u) {
			if (u->order_queue.empty()) return;
			if ((u_order_not_interruptible(u) || u_iscript_nobrk(u)) && u->order_queue.front().order_type->id != Orders::Die) return;
			const order_type_t* order_type = u->order_queue.front().order_type;
			order_target_t target = u->order_queue.front().target;
			remove_queued_order(u, &u->order_queue.front());

			u_unset_status_flag(u, unit_t::status_flag_8);
			u_unset_status_flag(u, unit_t::status_flag_ready_to_attack);
			u_set_status_flag(u, unit_t::status_flag_order_not_interruptible, !order_type->can_be_interrupted);
			u->order_process_timer = 0;
			u->move_target_timer = 0;

			u->order_type = order_type;
			u->order_state = 0;

			if (target.unit) {
				u->order_target.unit = target.unit;
				u->order_target.pos = target.unit->sprite->position;
				u->order_unit_type = nullptr;
			}
			else {
				u->order_target.unit = nullptr;
				u->order_target.pos = target.position;
				u->order_unit_type = target.unit_type;
			}
			u->auto_target_unit = nullptr;
			iscript_run_to_idle(u);
			if (!ut_turret(u) && u->subunit && ut_turret(u->subunit)) {
				const order_type_t* turret_order_type = order_type;
				if (order_type == u->unit_type->return_to_idle) turret_order_type = u->subunit->unit_type->return_to_idle;
				else if (order_type == u->unit_type->attack_unit) turret_order_type = u->subunit->unit_type->attack_unit;
				else if (order_type == u->unit_type->attack_move) turret_order_type = u->subunit->unit_type->attack_move;
				else if (!order_type->valid_for_turret) turret_order_type = nullptr;
				if (turret_order_type) {
					set_unit_order(u->subunit, turret_order_type, target);
				}
			}

		}

		image_t* find_image(sprite_t* sprite, ImageTypes first_id, ImageTypes last_id) const {
			for (image_t* i : ptr(sprite->images)) {
				if (i->image_type->id >= first_id && i->image_type->id <= last_id) return i;
			}
			return nullptr;
		}

		image_t* find_image(unit_t* u, ImageTypes first_id, ImageTypes last_id) const {
			image_t* r = find_image(u->sprite, first_id, last_id);
			if (!r && u->subunit) r = find_image(u->subunit->sprite, first_id, last_id);
			return r;
		}

		bool ut_worker(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_worker);
		}
		bool ut_resource(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_resource);
		}

		void remove_one_order(unit_t* u, const order_type_t* order_type) {
			for (order_t* o : ptr(u->order_queue)) {
				if (o->order_type == order_type) {
					remove_queued_order(u, o);
					break;
				}
			}
		}

		const order_type_t* get_order_type(Orders id) const {
			return &global_st.order_types.vec[(size_t)id];
		}

		void queue_order_front(unit_t* u, const order_type_t* order_type, order_target_t target) {
			queue_order(u->order_queue.begin(), u, order_type, target);
		}

		void order_done(unit_t* u, order_target_t target = {}) {
			if (!u->order_queue.empty()) {
				activate_next_order(u);
			}
			else set_unit_order(u, u->unit_type->return_to_idle, target);
		}

		bool try_gather_resource(unit_t* u, unit_t* target) {
			if (target->building.resource.is_being_gathered) return false;
			target->building.resource.is_being_gathered = true;
			u->worker.gather_target = target;
			u->worker.is_gathering = true;
			if (u->order_type->id == Orders::WaitForGas) {
				queue_order_front(u, get_order_type(Orders::HarvestGas), { target->sprite->position, target });
			}
			else {
				queue_order_front(u, get_order_type(Orders::GatheringInterrupted), {});
				queue_order_front(u, get_order_type(Orders::MiningMinerals), { target->sprite->position, target });
			}
			order_done(u);
			return true;
		}

		void disable_effect_end(unit_t* u, ImageTypes first, ImageTypes last) {
			bool still_disabled = unit_is_disabled(u);
			if (u->subunit && !still_disabled) {
				u_unset_status_flag(u->subunit, unit_t::status_flag_disabled);
				set_unit_order(u->subunit, u->subunit->unit_type->return_to_idle);
			}
			image_t* image = find_image(u->sprite, first, last);
			if (!image && u->subunit) image = find_image(u->subunit->sprite, first, last);
			if (image) iscript_run_anim(image, iscript_anims::Death);
			if (ut_worker(u) && !still_disabled) {
				unit_t* target = u->worker.gather_target;
				if (target && ut_resource(target)) {
					if (u->worker.is_gathering && target->building.resource.is_being_gathered) {
						if (u->order_type->id == Orders::WaitForMinerals || u->order_type->id == Orders::WaitForGas) {
							if (u->order_state == 2) {
								target->building.resource.gather_queue.remove(*u);
								remove_one_order(u, get_order_type(Orders::GatherWaitInterrupted));
								try_gather_resource(u, target);
							}
						}
					}
				}
			}
			u->order_process_timer = 15;
		}

		void remove_stasis(unit_t* u) {
			u->stasis_timer = 0;
			u_set_status_flag(u, unit_t::status_flag_invincible, ut_invincible(u));
			disable_effect_end(u, ImageTypes::IMAGEID_Stasis_Field_Small, ImageTypes::IMAGEID_Stasis_Field_Large);
		}

		bool u_speed_upgrade(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_speed_upgrade);
		}
		fp8 get_modified_unit_acceleration(const unit_t* u, fp8 base_acceleration) const {
			ufp8 acceleration = base_acceleration.as_unsigned();
			int mod = 0;
			if (u->stim_timer) ++mod;
			if (u_speed_upgrade(u)) ++mod;
			if (u->ensnare_timer) --mod;
			if (mod < 0) acceleration -= acceleration / 4u;
			if (mod > 0) acceleration *= 2u;
			return acceleration.as_signed();
		}

		bool unit_is_scout(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Protoss_Scout) || unit_is(ut, UnitTypes::Hero_Mojo) || unit_is(ut, UnitTypes::Hero_Artanis);
		}
		fp8 get_modified_unit_speed(const unit_t* u, fp8 base_speed) const {
			ufp8 speed = base_speed.as_unsigned();
			int mod = 0;
			if (u->stim_timer) ++mod;
			if (u_speed_upgrade(u)) ++mod;
			if (u->ensnare_timer) --mod;
			if (mod < 0) speed /= 2u;
			if (mod > 0) {
				if (unit_is_scout(u)) {
					speed = ufp8::integer(6) + (ufp8::integer(1) - ufp8::integer(1) / 3u);
				}
				else {
					speed += speed / 2u;
					ufp8 min_speed = ufp8::integer(3) + ufp8::integer(1) / 3u;
					if (speed < min_speed) speed = min_speed;
				}
			}
			return speed.as_signed();
		}

		fp8 get_modified_unit_turn_rate(const unit_t* u, fp8 base_turn_rate) const {
			ufp8 turn_rate = base_turn_rate.as_unsigned();
			int mod = 0;
			if (u->stim_timer) ++mod;
			if (u_speed_upgrade(u)) ++mod;
			if (u->ensnare_timer) --mod;
			if (mod < 0) turn_rate -= turn_rate / 4u;
			if (mod > 0) turn_rate *= 2u;
			return turn_rate.as_signed();
		}

		void update_unit_speed(unit_t* u) {

			if (u->flingy_movement_type == 2) {
				image_t* image = u->sprite->main_image;
				fp8 total_distance_moved{};
				for (int i = 0; i < 32; ++i) {
					fp8 distance_moved{};
					// This get_modified_unit_acceleration is very out of place, and
					// it makes the stored flingy_top_speed value wrong. But BroodWar does it.
					// It's probably a bug, but the value might not be used for anything
					// significant.
					total_distance_moved += get_modified_unit_acceleration(u, distance_moved);
				}
				auto avg_distance_moved = total_distance_moved / 32;
				u->flingy_top_speed = avg_distance_moved;
			}
			else {
				u->flingy_top_speed = get_modified_unit_speed(u, u->flingy_type->top_speed);
				u->flingy_acceleration = get_modified_unit_acceleration(u, u->flingy_type->acceleration);
				u->flingy_turn_rate = get_modified_unit_turn_rate(u, u->flingy_type->turn_rate);
			}

		}

		void destroy_image(image_t* image) {
			image->sprite->images.remove(*image);
			st.images_container.push(image);
		}

		void destroy_image_from_to(sprite_t* sprite, ImageTypes first_id, ImageTypes last_id) {
			image_t* image = find_image(sprite, first_id, last_id);
			if (image) destroy_image(image);
		}

		void destroy_image_from_to(unit_t* u, ImageTypes first_id, ImageTypes last_id) {
			destroy_image_from_to(u->sprite, first_id, last_id);
			if (u->subunit) destroy_image_from_to(u->subunit->sprite, first_id, last_id);
		}

		void remove_irradiate(unit_t* u) {
			u->irradiate_timer = 0;
			u->irradiated_by = 0;
			u->irradiate_owner = 8;
			destroy_image_from_to(u, ImageTypes::IMAGEID_Irradiate_Small, ImageTypes::IMAGEID_Irradiate_Large);
		}

		void remove_ensnare(unit_t* u) {
			u->ensnare_timer = 0;
			destroy_image_from_to(u, ImageTypes::IMAGEID_Ensnare_Overlay_Small, ImageTypes::IMAGEID_Ensnare_Overlay_Large);
			update_unit_speed(u);
		}

		void remove_lockdown(unit_t* u) {
			u->lockdown_timer = 0;
			disable_effect_end(u, ImageTypes::IMAGEID_Lockdown_Field_Small, ImageTypes::IMAGEID_Lockdown_Field_Large);
		}

		void remove_plague(unit_t* u) {
			u->plague_timer = 0;
			destroy_image_from_to(u, ImageTypes::IMAGEID_Plague_Overlay_Small, ImageTypes::IMAGEID_Plague_Overlay_Large);
		}

		void remove_maelstrom(unit_t* u) {
			u->maelstrom_timer = 0;
			disable_effect_end(u, ImageTypes::IMAGEID_Maelstorm_Overlay_Small, ImageTypes::IMAGEID_Maelstorm_Overlay_Large);
		}

		void remove_acid_spores(unit_t* u) {
			u->acid_spore_count = 0;
			u->acid_spore_time = {};
			destroy_image_from_to(u, ImageTypes::IMAGEID_Acid_Spores_1_Overlay_Small, ImageTypes::IMAGEID_Acid_Spores_6_9_Overlay_Large);
		}

		image_t* create_sized_image(unit_t* u, ImageTypes small_image) {
			return nullptr;
		}

		void deal_defensive_matrix_damage(unit_t* u, fp8 damage) {
			if (damage < u->defensive_matrix_hp) {
				u->defensive_matrix_hp -= damage;
			}
			else {
				u->defensive_matrix_hp = 0_fp8;
				u->defensive_matrix_timer = 0;
				destroy_image_from_to(u, ImageTypes::IMAGEID_Defensive_Matrix_Front_Small, ImageTypes::IMAGEID_Defensive_Matrix_Front_Large);
				destroy_image_from_to(u->sprite, ImageTypes::IMAGEID_Defensive_Matrix_Back_Small, ImageTypes::IMAGEID_Defensive_Matrix_Back_Large);
			}
			if (u->defensive_matrix_timer && !u_burrowed(u)) {
				create_sized_image(u, ImageTypes::IMAGEID_Defensive_Matrix_Hit_Small);
			}
		}

		bool ut_organic(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_organic);
		}

		bool u_loaded(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_loaded);
		}

		bool unit_target_in_range(const unit_t* u, const unit_t* target, int range) const {
			return units_distance(unit_main_unit(u), target) <= range;
		}

		int units_distance(const unit_t* a, const unit_t* b) const {
			auto a_rect = unit_sprite_bounding_box(a);
			auto b_rect = unit_sprite_bounding_box(b);
			return xy_length(rect_difference(a_rect, b_rect));
		}

		xy rect_difference(rect a, rect b) const {
			int x, y;
			if (a.from.x > b.to.x) x = a.from.x - b.to.x;
			else if (b.from.x > a.to.x) x = b.from.x - a.to.x;
			else x = 0;
			if (a.from.y > b.to.y) y = a.from.y - b.to.y;
			else if (b.from.y > a.to.y) y = b.from.y - a.to.y;
			else y = 0;

			return xy(x, y);
		}

		const weapon_type_t* get_weapon_type(WeaponTypes id) const {
			return &game_st.weapon_types.vec[(size_t)id];
		}

		bool u_invincible(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_invincible);
		}

		bool u_hallucination(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_hallucination);
		}

		int player_upgrade_level(int owner, UpgradeTypes upgrade_id) const {
			return st.upgrade_levels.at(owner).at(upgrade_id);
		}

		bool unit_is_ultralisk(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Zerg_Ultralisk)) return true;
			if (unit_is(ut, UnitTypes::Hero_Torrasque)) return true;
			return false;
		}

		bool player_has_upgrade(int owner, UpgradeTypes upgrade_id) const {
			return st.upgrade_levels.at(owner).at(upgrade_id) != 0;
		}
		fp8 unit_armor(const unit_t* u) const {
			fp8 r = fp8::integer(u->unit_type->armor);
			if (unit_is_ultralisk(u) && player_has_upgrade(u->owner, UpgradeTypes::Chitinous_Plating)) r += fp8::integer(2);
			r += fp8::integer(player_upgrade_level(u->owner, u->unit_type->armor_upgrade));
			return r;
		}

		bool u_requires_detector(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_requires_detector);
		}
		bool u_cloaked(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_cloaked);
		}
		bool unit_is_undetected(const unit_t* u, int owner) const {
			if (!u_cloaked(u) && !u_requires_detector(u)) return false;
			if (u->detected_flags & (1 << owner)) return false;
			return true;
		}

		bool unit_target_is_undetected(const unit_t* u, const unit_t* target) const {
			return unit_is_undetected(target, u->owner);
		}

		const std::vector<cv5_entry>& cv5() const {
			return global_st.get_cv5(0);
		}

		int get_ground_height_at(xy pos) const {
			// TODO: No ground height in Factorio
			return 0;
		}

		void reveal_sight_at(xy pos, int range, int reveal_to, bool in_air) {
			// TODO: Using Factorio sight mechanics
		}

		bool unit_is_carrier(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Protoss_Carrier) || unit_is(ut, UnitTypes::Hero_Gantrithor);
		}

		bool unit_is_reaver(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Protoss_Reaver) || unit_is(ut, UnitTypes::Hero_Warbringer);
		}

		bool unit_is_queen(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Zerg_Queen) || unit_is(ut, UnitTypes::Hero_Matriarch);
		}

		int max_visible_hp(const unit_t* u) const {
			int hp = u->unit_type->hitpoints.integer_part();
			if (hp == 0) hp = u->hp.ceil().integer_part();
			if (hp == 0) hp = 1;
			return hp;
		}
		int unit_hp_percent(const unit_t* u) const {
			int max_hp = max_visible_hp(u);
			int hp = u->hp.ceil().integer_part();
			return hp * 100 / max_hp;
		}

		bool unit_can_be_infested(const unit_t* u) const {
			if (!unit_is(u, UnitTypes::Terran_Command_Center)) return false;
			if (!u_completed(u)) return false;
			return unit_hp_percent(u) < 50;
		}

		const weapon_type_t* unit_air_weapon(const unit_t* u) const {
			return u->unit_type->air_weapon;
		}

		const unit_t* unit_attacking_unit(const unit_t* u) const {
			return u->subunit && ut_turret(u->subunit) ? u->subunit : u;
		}

		const weapon_type_t* unit_ground_weapon(const unit_t* u) const {
			if (unit_is(u, UnitTypes::Zerg_Lurker) && !u_burrowed(u)) return nullptr;
			return u->unit_type->ground_weapon;
		}

		const weapon_type_t* unit_target_weapon(const unit_t* u, const unit_t* target) const {
			return u_flying(target) ? unit_air_weapon(unit_attacking_unit(u)) : unit_ground_weapon(unit_attacking_unit(u));
		}

		bool unit_can_attack_target(const unit_t* u, const unit_t* target) const {
			if (!target) return false;
			if (unit_is_disabled(u)) return false;
			if (u_invincible(target)) return false;
			if (us_hidden(target)) return false;
			if (unit_target_is_undetected(u, target)) return false;
			if (unit_is_carrier(u)) return true;
			if (unit_is_reaver(u)) {
				if (u_flying(target)) return false;
				return is_reachable(u->sprite->position, target->sprite->position);
			}
			if (unit_is_queen(u)) {
				return unit_can_be_infested(target);
			}
			return unit_target_weapon(u, target) != nullptr;
		}

		bool unit_target_is_visible(const unit_t* u, const unit_t* target) const {
			return (target->sprite->visibility_flags & (1 << u->owner)) != 0;
		}

		bool unit_can_see_target(const unit_t* u, const unit_t* target) const {
			if (unit_target_is_undetected(u, target)) return false;
			return unit_target_is_visible(u, target);
		}

		int weapon_max_range(const unit_t* u, const weapon_type_t* w) const {
			auto range_upgrade_bonus = [&]() {
				switch (u->unit_type->id) {
				case UnitTypes::Terran_Marine:
					return player_has_upgrade(u->owner, UpgradeTypes::U_238_Shells) ? 32 : 0;
				case UnitTypes::Zerg_Hydralisk:
					return player_has_upgrade(u->owner, UpgradeTypes::Grooved_Spines) ? 32 : 0;
				case UnitTypes::Protoss_Dragoon:
					return player_has_upgrade(u->owner, UpgradeTypes::Singularity_Charge) ? 64 : 0;
				case UnitTypes::Hero_Fenix_Dragoon:
					return 64;
				case UnitTypes::Terran_Goliath:
				case UnitTypes::Terran_Goliath_Turret:
					return w->id == WeaponTypes::Hellfire_Missile_Pack && player_has_upgrade(u->owner, UpgradeTypes::Charon_Boosters) ? 96 : 0;
				case UnitTypes::Hero_Alan_Schezar:
				case UnitTypes::Hero_Alan_Schezar_Turret:
					return w->id == WeaponTypes::Hellfire_Missile_Pack_Alan_Schezar ? 96 : 0;
				default:
					return 0;
				};
			};
			int r = w->max_range;
			if (u_in_bunker(u)) r += 64;
			r += range_upgrade_bonus();
			return r;
		}

		int unit_target_movement_range(const flingy_t* u, const flingy_t* target) const {
			if (!u_movement_flag(u, 2)) return 0;
			if (u_movement_flag(target, 2)) {
				if (fp8::extend(target->next_velocity_direction - u->next_velocity_direction).abs() <= 32_fp8) return 0;
			}
			return unit_halt_distance(u).integer_part();
		}

		bool unit_target_in_weapon_movement_range(const unit_t* u, const unit_t* target) const {
			if (!target) target = u->order_target.unit;
			if (!target) return true;
			if (!unit_can_see_target(u, target)) return false;
			auto* w = unit_target_weapon(u, target);
			if (!w) return false;
			int d = units_distance(unit_main_unit(u), target);
			if (w->min_range && d <= w->min_range) return false;
			int max_range = weapon_max_range(u, w);
			max_range += unit_target_movement_range(u, target);
			return d <= max_range;
		}
		bool on_hit_should_change_target(const unit_t* u, const unit_t* old_target, const unit_t* new_target) const {
			if (old_target == new_target) return false;
			if (!unit_target_is_enemy(u, new_target)) return false;

			if (!old_target) return true;
			if (!unit_can_attack_target(u, old_target)) return true;
			if (!unit_target_is_enemy(u, old_target)) return true;
			if (unit_target_in_weapon_movement_range(u, new_target) && !unit_target_in_weapon_movement_range(u, old_target)) return true;
			return false;
		}

		bool ut_can_burrow(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_can_burrow);
		}

		void unburrow_unit(unit_t* u) {
			if (u->order_type->id != Orders::Burrowing && u->order_type->id != Orders::Burrowed && !unit_is(u, UnitTypes::Zerg_Lurker)) return;
			if (unit_is(u, UnitTypes::Zerg_Lurker)) u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
			set_unit_order(u, get_order_type(Orders::Unburrowing));
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		unit_t* unit_turret(const unit_t* u) const {
			if (!u->subunit) return nullptr;
			if (!ut_turret(u->subunit)) return nullptr;
			return u->subunit;
		}

		unit_t* unit_main_unit(unit_t* u) const {
			return ut_turret(u) ? u->subunit : u;
		}

		template<typename F>
		unit_t* find_unit(rect area, F&& predicate) const {
			for (unit_t* u : find_units(area)) {
				if (predicate(u)) return u;
			}
			return nullptr;
		}

		bool unit_is_under_dark_swarm(const unit_t* u) const {
			if (ut_building(u)) return false;
			if (st.completed_unit_counts[11][UnitTypes::Spell_Dark_Swarm] == 0) return false;
			return find_unit(unit_sprite_inner_bounding_box(u), [&](const unit_t* n) {
				return unit_is(n, UnitTypes::Spell_Dark_Swarm);
				}) != nullptr;
		}

		fp8 unit_dodge_chance(const unit_t* u) const {
			if (u_flying(u)) return 0_fp8;
			if (unit_is_under_dark_swarm(u)) return 255_fp8;
			if (st.tiles[tile_index(u->sprite->position)].flags & tile_t::flag_provides_cover) return 119_fp8;
			return 0_fp8;
		}

		void on_hit_change_target(unit_t* u, unit_t* target) {
			if (unit_is(u, UnitTypes::Zerg_Larva)) return;
			if (u_burrowed(u) && !unit_is(u, UnitTypes::Zerg_Lurker) && u->irradiate_timer == 0) {
				if (ut_can_burrow(u)) unburrow_unit(u);
				return;
			}
			if (ut_building(u) || (!ut_worker(u) && unit_can_attack_target(u, target))) {
				u->auto_target_unit = target;
				unit_t* turret = unit_turret(u);
				if (turret) {
					turret->last_attacking_player = u->last_attacking_player;
					turret->auto_target_unit = target;
				}
			}
			else {
				if (!u_burrowed(u) || !unit_is(u, UnitTypes::Zerg_Lurker)) {
					u = unit_main_unit(u);
					if (u->order_type->unk11 && u_can_move(u)) {
						if (unit_dodge_chance(u) < 255_fp8) {
							auto flee_dir = direction_xy(xy_direction(u->sprite->position - target->sprite->position));
							xy flee_pos = u->sprite->position;
							std::array<int, 5> length = { 192, 128, 64, 32, 16 };
							for (auto v : length) {
								xy pos = u->sprite->position + to_xy(flee_dir * v);
								if (~u->pathing_flags & 1) {
									flee_pos = pos;
									break;
								}
							}
							set_unit_order(u, get_order_type(Orders::Move), flee_pos);
						}
					}
				}
			}
		}

		bool unit_is_arbiter(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Protoss_Arbiter)) return true;
			if (unit_is(ut, UnitTypes::Hero_Danimoth)) return true;
			return false;
		}

		const weapon_type_t* unit_or_subunit_ground_weapon(const unit_t* u) const {
			auto* w = unit_ground_weapon(u);
			if (w || !u->subunit) return w;
			return unit_ground_weapon(u->subunit);
		}

		const weapon_type_t* unit_or_subunit_air_weapon(const unit_t* u) const {
			auto* w = unit_air_weapon(u);
			if (w || !u->subunit) return w;
			return unit_air_weapon(u->subunit);
		}

		size_t unit_interceptor_count(const unit_t* u) const {
			if (!unit_is_carrier(u)) return 0;
			return u->carrier.inside_count + u->carrier.outside_count;
		}
		size_t unit_scarab_count(const unit_t* u) const {
			if (!unit_is_reaver(u)) return 0;
			return u->reaver.inside_count;
		}

		bool unit_can_attack(const unit_t* u) const {
			if (unit_or_subunit_ground_weapon(u) || unit_or_subunit_air_weapon(u)) return true;
			if (unit_interceptor_count(u)) return true;
			if (unit_scarab_count(u)) return true;
			return false;
		}

		void on_hit_aoe_change_target(unit_t* u, unit_t* target) {
			if (unit_is_arbiter(u)) return;
			if (ut_worker(u)) return;
			if (u_burrowed(u)) return;
			if (!unit_can_attack(u)) return;
			if (on_hit_should_change_target(u, u->auto_target_unit, target)) {
				u->auto_target_unit = target;
				unit_t* turret = unit_turret(u);
				if (turret) {
					turret->last_attacking_player = u->last_attacking_player;
					turret->auto_target_unit = target;
				}
			}
		}

		void on_unit_damage(unit_t* u, unit_t* source_unit, bool reveal_source) {
			if (!source_unit || source_unit->owner == u->owner) return;
			u->last_attacking_player = source_unit->owner;
			if (reveal_source && !unit_target_is_undetected(u, source_unit) && u->owner < 8) {
				// TODO: Using Factorio sight mechanics
				//reveal_sight_at(source_unit->sprite->position, 1, 1 << u->owner, u_flying(source_unit));
			}
			if (u_in_bunker(source_unit)) {
				source_unit = source_unit->connected_unit;
			}
			if (on_hit_should_change_target(u, u->auto_target_unit, source_unit)) {
				on_hit_change_target(u, source_unit);
			}
			rect bb{ u->sprite->position - xy(96, 96), u->sprite->position + xy(96, 96) };
			for (unit_t* n : find_units_noexpand(bb)) {
				if (n != u && n->owner == u->owner) {
					on_hit_aoe_change_target(n, source_unit);
				}
			}
		}

		const image_type_t* get_image_type(ImageTypes id) const {
			return &global_st.image_types.vec[(size_t)id];
		}
		void update_unit_damage_overlay(unit_t* u) {
			// TODO: handled already
		}

		bool unit_is_egg(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Zerg_Egg)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Cocoon)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Lurker_Egg)) return true;
			return false;
		}

		int visible_hp_plus_shields(const unit_t* u) const {
			int r = 0;
			if (u->unit_type->has_shield) r += u->shield_points.integer_part();
			r += u->hp.ceil().integer_part();
			return r;
		}

		int max_visible_hp_plus_shields(const unit_t* u) const {
			int shields = 0;
			if (u->unit_type->has_shield) shields += u->unit_type->shield_points;
			return max_visible_hp(u) + shields;
		}

		auto loaded_units(const unit_t* u) const {
			return make_filter_range(make_transform_range(u->loaded_units, [this](auto uid) {
				return this->get_unit(uid);
				}), [](unit_t* u) {
					return u != nullptr;
				});
		}

		size_t unit_space_occupied(const unit_t* u) const {
			size_t r = 0;
			for (const unit_t* nu : loaded_units(u)) {
				r += nu->unit_type->space_required;
			}
			return r;
		}

		bool ut_has_energy(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_has_energy);
		}

		bool unit_provides_space(const unit_t* u) const {
			if (!u->unit_type->space_provided) return false;
			if (unit_is(u, UnitTypes::Zerg_Overlord) && !player_has_upgrade(u->owner, UpgradeTypes::Ventral_Sacs)) return false;
			if (u_hallucination(u)) return false;
			return true;
		}

		void drop_carried_items(unit_t* u) {
			if ((u->carrying_flags & ~3) == 0) return;
		}

		void kill_unit(unit_t* u) {
			drop_carried_items(u);
			while (!u->order_queue.empty()) {
				remove_queued_order(u, &u->order_queue.front());
			}
			set_unit_order(u, get_order_type(Orders::Die), u->order_target.pos);
		}

		void unit_deal_damage(unit_t* u, fp8 damage, unit_t* source_unit, int source_owner, bool reveal_source = true) {
			(void)source_owner;
			if (u->hp == 0_fp8) return;
			on_unit_damage(u, source_unit, reveal_source);
			if (damage < u->hp) {
				u->hp -= damage;
				if (u_completed(u)) {
					update_unit_damage_overlay(u);
				}
			}
			else {
				if (unit_provides_space(u) && !ut_building(u)) {
					for (unit_t* n : loaded_units(u)) {
						kill_unit(n);
						// todo: units lost scores
					}
				}
				u->hp = 0_fp8;
				kill_unit(u);
			}
		}

		void weapon_deal_damage(const weapon_type_t* weapon, fp8 damage, int damage_divisor, unit_t* target, direction_t heading, unit_t* source_unit, int source_owner) {
			// TODO: Dealt with in Factorio
		}

		rect square_at(xy pos, int half_width) const {
			return { pos - xy(half_width, half_width), pos + xy(half_width, half_width) };
		}

		void deal_irradiate_damage(unit_t* source_unit) {
			auto damage = [&](unit_t* target) {
				if (!ut_organic(target)) return;
				if (ut_building(target)) return;
				if (unit_is(target, UnitTypes::Zerg_Larva)) return;
				if (unit_is(target, UnitTypes::Zerg_Egg)) return;
				if (unit_is(target, UnitTypes::Zerg_Lurker_Egg)) return;
				if (u_burrowed(target) && target != source_unit) return;
				if (!u_loaded(target)) {
					if (!unit_target_in_range(source_unit, target, 32)) return;
				}
				auto* w = get_weapon_type(WeaponTypes::Irradiate);
				weapon_deal_damage(w, fp8::integer(w->damage_amount) / w->cooldown, 1, target, 0_dir, source_unit->irradiated_by, source_unit->irradiate_owner);
			};
			if (u_burrowed(source_unit)) {
				damage(source_unit);
			}
			else if (u_loaded(source_unit)) {
				if (source_unit->connected_unit) damage(source_unit->connected_unit);
			}
			else {
				for (unit_t* n : find_units_noexpand(square_at(source_unit->sprite->position, 160))) {
					damage(n);
				}
			}
		}

		int unit_sprite_size(unit_type_autocast ut) const {
			if (ut_flag(ut, unit_type_t::flag_sprite_size_medium)) return 1;
			if (ut_flag(ut, unit_type_t::flag_sprite_size_large)) return 2;
			return 0;
		}
		ImageTypes acid_spore_image(const unit_t* u) const {
			size_t n = std::min((size_t)(u->acid_spore_count / 2), (size_t)3);
			return (ImageTypes)((int)ImageTypes::IMAGEID_Acid_Spores_1_Overlay_Small + 4 * unit_sprite_size(u) + n);
		}

		void update_acid_spore_image(unit_t* u) {
			ImageTypes image_id = acid_spore_image(u);
			if (!find_image(u, image_id, image_id)) {
				destroy_image_from_to(u, ImageTypes::IMAGEID_Acid_Spores_1_Overlay_Small, ImageTypes::IMAGEID_Acid_Spores_6_9_Overlay_Large);
				// TODO
				//create_image(get_image_type(image_id), (u->subunit ? u->subunit : u)->sprite, {}, image_order_top);
			}
		}

		void update_unit_status_timers(unit_t* u) {
			if (u->stasis_timer) {
				--u->stasis_timer;
				if (!u->stasis_timer) {
					remove_stasis(u);
				}
			}
			if (u->stim_timer) {
				--u->stim_timer;
				if (!u->stim_timer) {
					update_unit_speed(u);
				}
			}
			if (u->ensnare_timer) {
				--u->ensnare_timer;
				if (!u->ensnare_timer) {
					remove_ensnare(u);
				}
			}
			if (u->defensive_matrix_timer) {
				--u->defensive_matrix_timer;
				if (!u->defensive_matrix_timer) {
					deal_defensive_matrix_damage(u, u->defensive_matrix_hp);
				}
			}
			if (u->irradiate_timer) {
				--u->irradiate_timer;
				deal_irradiate_damage(u);
				if (!u->irradiate_timer) {
					remove_irradiate(u);
				}
			}
			if (u->lockdown_timer) {
				--u->lockdown_timer;
				if (!u->lockdown_timer) {
					remove_lockdown(u);
				}
			}
			if (u->maelstrom_timer) {
				--u->maelstrom_timer;
				if (!u->maelstrom_timer) {
					remove_maelstrom(u);
				}
			}
			if (u->plague_timer) {
				--u->plague_timer;
				if (!u_invincible(u)) {
					auto damage = fp8::integer(get_weapon_type(WeaponTypes::Plague)->damage_amount) / 76;
					if (u->hp > damage) unit_deal_damage(u, damage, nullptr, ~0, true);
				}
				if (!u->plague_timer) {
					remove_plague(u);
				}
			}
			if (u->storm_timer) --u->storm_timer;
			int prev_acid_spore_count = u->acid_spore_count;
			if (prev_acid_spore_count) {
				for (auto& v : u->acid_spore_time) {
					if (!v) continue;
					--v;
					if (!v) --u->acid_spore_count;
				}
				if (u->acid_spore_count) {
					update_acid_spore_image(u);
				}
				else {
					remove_acid_spores(u);
				}
			}

		}

		bool ut_regens_hp(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_regens_hp);
		}
		void set_unit_hp(unit_t* u, fp8 hitpoints) {
			u->hp = std::min(hitpoints, u->unit_type->hitpoints);
			if (u_completed(u)) {
				update_unit_damage_overlay(u);
			}
		}

		bool u_passively_cloaked(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_passively_cloaked);
		}

		fp8 unit_cloak_energy_cost(const unit_t* u) const {
			switch (u->unit_type->id) {
			case UnitTypes::Terran_Ghost:
			case UnitTypes::Hero_Sarah_Kerrigan:
			case UnitTypes::Hero_Alexei_Stukov:
			case UnitTypes::Hero_Samir_Duran:
			case UnitTypes::Hero_Infested_Duran:
			case UnitTypes::Hero_Infested_Kerrigan:
				return 10_fp8;
			case UnitTypes::Terran_Wraith:
			case UnitTypes::Hero_Tom_Kazansky:
				return 13_fp8;
			default:
				return 0_fp8;
			}
		}

		void set_secondary_order(unit_t* u, const order_type_t* order_type) {
			if (u->secondary_order_type == order_type) return;
			u->secondary_order_type = order_type;
			u->secondary_order_state = 0;
			u->current_build_unit = nullptr;
		}

		bool ut_hero(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_hero);
		}
		fp8 unit_max_energy(const unit_t* u) const {
			if (ut_hero(u)) return fp8::integer(250);
			auto energy_upgrade = [&]() {
				switch (u->unit_type->id) {
				case UnitTypes::Terran_Ghost: return UpgradeTypes::Moebius_Reactor;
				case UnitTypes::Terran_Wraith: return UpgradeTypes::Apollo_Reactor;
				case UnitTypes::Terran_Science_Vessel: return UpgradeTypes::Titan_Reactor;
				case UnitTypes::Terran_Battlecruiser: return UpgradeTypes::Colossus_Reactor;
				case UnitTypes::Terran_Medic: return UpgradeTypes::Caduceus_Reactor;
				case UnitTypes::Zerg_Queen: return UpgradeTypes::Gamete_Meiosis;
				case UnitTypes::Zerg_Defiler: return UpgradeTypes::Metasynaptic_Node;
				case UnitTypes::Protoss_Corsair: return UpgradeTypes::Argus_Jewel;
				case UnitTypes::Protoss_Dark_Archon: return UpgradeTypes::Argus_Talisman;
				case UnitTypes::Protoss_High_Templar: return UpgradeTypes::Khaydarin_Amulet;
				case UnitTypes::Protoss_Arbiter: return UpgradeTypes::Khaydarin_Core;
				default: return UpgradeTypes::None;
				};
			};
			auto upg = energy_upgrade();
			if (upg != UpgradeTypes::None && player_has_upgrade(u->owner, upg)) return fp8::integer(250);
			else return fp8::integer(200);
		}

		void update_unit_energy(unit_t* u) {
			if (!ut_has_energy(u)) return;
			if (u_hallucination(u)) return;
			if (!u_completed(u)) return;
			if ((u_cloaked(u) || u_requires_detector(u)) && !u_passively_cloaked(u)) {
				fp8 cost = unit_cloak_energy_cost(u);
				if (u->energy < cost) {
					if (u->secondary_order_type->id == Orders::Cloak) set_secondary_order(u, get_order_type(Orders::Nothing));
				}
				else {
					u->energy -= cost;
				}
			}
			else {
				fp8 max_energy = unit_max_energy(u);
				if (unit_is(u, UnitTypes::Protoss_Dark_Archon) && u->order_type->id == Orders::CompletingArchonSummon && u->order_state == 0) {
					max_energy = fp8::integer(50);
				}
				u->energy = std::min(u->energy + 8_fp8, max_energy);
			}
		}

		race_t unit_race(unit_type_autocast ut) const {
			if (ut->group_flags & GroupFlags::Zerg) return race_t::zerg;
			if (ut->group_flags & GroupFlags::Terran) return race_t::terran;
			if (ut->group_flags & GroupFlags::Protoss) return race_t::protoss;
			return race_t::none;
		}

		bool ut_flying_building(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_flying_building);
		}
		void update_unit_values(unit_t* u) {
			if (u->main_order_timer) --u->main_order_timer;
			if (u->ground_weapon_cooldown) --u->ground_weapon_cooldown;
			if (u->air_weapon_cooldown) --u->air_weapon_cooldown;
			if (u->spell_cooldown) --u->spell_cooldown;

			if (unit_is(u, UnitTypes::Zerg_Zergling) || unit_is(u, UnitTypes::Hero_Devouring_One)) {
				if (u->ground_weapon_cooldown == 0) u->order_process_timer = 0;
			}
			if (u->is_being_healed) u->is_being_healed = false;
			if (u_completed(u) || !us_hidden(u)) {
				++u->cycle_counter;
				if (u->cycle_counter >= 8) {
					u->cycle_counter = 0;
					update_unit_status_timers(u);
				}
			}
			if (u_completed(u)) {
				if (ut_regens_hp(u)) {
					if (u->hp > 0_fp8 && u->hp != u->unit_type->hitpoints) {
						set_unit_hp(u, u->hp + 4_fp8);
					}
				}
				update_unit_energy(u);
				if (u->move_target_timer) --u->move_target_timer;
				if (u->remove_timer != 0 && --u->remove_timer == 0) {
					kill_unit(u);
				}
				else {
					if (unit_race(u) == race_t::terran) {
						if (u_grounded_building(u) || ut_flying_building(u)) {
							if (unit_hp_percent(u) <= 33) {
								unit_deal_damage(u, 20_fp8, nullptr, u->last_attacking_player);
							}
						}
					}
				}
			}
		}

		void order_Stop(unit_t* u) {
			stop_unit(u);
			set_next_target_waypoint(u, u->move_target.pos);
			iscript_run_to_idle(u);
			order_done(u);
		}

		void order_Guard(unit_t* u) {
			u->main_order_timer = lcg_rand(29, 0, 15);
			u->order_type = get_order_type(Orders::PlayerGuard);
		}

		void auto_attack_target(unit_t* u, unit_t* target) {
			if (unit_is(target, UnitTypes::Protoss_Interceptor)) {
				if (target->fighter.parent) target = target->fighter.parent;
			}
			set_unit_order(u, u->unit_type->attack_unit, target);
			u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
			if (u->subunit) {
				if (ut_turret(u->subunit)) {
					set_unit_order(u->subunit, u->subunit->unit_type->attack_unit, target);
				}
				u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
			}
		}

		bool unit_autoattack(unit_t* u) {
			if (!u->auto_target_unit) return false;
			if (unit_target_is_enemy(u, u->auto_target_unit) && unit_can_attack_target(u, u->auto_target_unit)) {
				auto_attack_target(u, u->auto_target_unit);
				u_set_status_flag(u, unit_t::status_flag_8);
				return true;
			}
			else {
				u->auto_target_unit = nullptr;
				return false;
			}
		}

		bool unit_is_ghost(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Ghost)) return true;
			if (unit_is(ut, UnitTypes::Hero_Sarah_Kerrigan)) return true;
			if (unit_is(ut, UnitTypes::Hero_Alexei_Stukov)) return true;
			if (unit_is(ut, UnitTypes::Hero_Samir_Duran)) return true;
			if (unit_is(ut, UnitTypes::Hero_Infested_Duran)) return true;
			return false;
		}

		int unit_target_acquisition_range(const unit_t* u) const {
			if ((u_cloaked(u) || u_requires_detector(u)) && u->order_type->id != Orders::HoldPosition) {
				if (unit_is_ghost(u)) return 0;
			}
			int bonus = 0;
			if (unit_is(u, UnitTypes::Terran_Marine) && player_has_upgrade(u->owner, UpgradeTypes::U_238_Shells)) bonus = 1;
			if (unit_is(u, UnitTypes::Zerg_Hydralisk) && player_has_upgrade(u->owner, UpgradeTypes::Grooved_Spines)) bonus = 1;
			if (unit_is(u, UnitTypes::Protoss_Dragoon) && player_has_upgrade(u->owner, UpgradeTypes::Singularity_Charge)) bonus = 2;
			if (unit_is(u, UnitTypes::Hero_Fenix_Dragoon)) bonus = 2;
			if (unit_is(u, UnitTypes::Terran_Goliath) && player_has_upgrade(u->owner, UpgradeTypes::Charon_Boosters)) bonus = 3;
			if (unit_is(u, UnitTypes::Terran_Goliath_Turret) && player_has_upgrade(u->owner, UpgradeTypes::Charon_Boosters)) bonus = 3;
			if (unit_is(u, UnitTypes::Hero_Alan_Schezar)) bonus = 3;
			if (unit_is(u, UnitTypes::Hero_Alan_Schezar_Turret)) bonus = 3;
			return u->unit_type->target_acquisition_range + bonus;
		}

		unit_t* unit_first_loaded_unit(const unit_t* u) const {
			for (unit_t* nu : loaded_units(u)) {
				return nu;
			}
			return nullptr;
		}

		bool u_cannot_attack(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_cannot_attack);
		}
		int unit_target_attack_priority(const unit_t* u, const unit_t* target) const {
			bool is_loaded_unit = false;
			if (unit_is(target, UnitTypes::Terran_Bunker)) {
				const unit_t* loaded_unit = unit_first_loaded_unit(target);
				if (loaded_unit) {
					target = loaded_unit;
					is_loaded_unit = true;
				}
			}
			if (unit_is(target, UnitTypes::Zerg_Larva)) return 5;
			if (unit_is_egg(target)) return 5;
			int r = 0;
			if (ut_worker(target)) r += 2;
			else if (!unit_can_attack_target(target, u)) {
				if (unit_can_attack(target)) r += 2;
				else if (u_can_move(target)) r += 3;
				else r += 4;
			}
			if (is_loaded_unit || !u_completed(target)) ++r;
			if (r == 0 && u_cannot_attack(target)) ++r;
			return r;
		}

		bool unit_target_in_attack_angle(const unit_t* u, xy target_pos, const weapon_type_t* weapon) const {
			auto dir = xy_direction(target_pos - u->sprite->position);
			if (unit_is(u, UnitTypes::Zerg_Lurker)) {
				// For some reason, this field is set here for lurkers, but I would really like u to be const.
				// todo: figure out if it is necessary.
				//u->heading = dir;
				return true;
			}
			return fp8::extend(dir - u->heading).abs() <= weapon->attack_angle;
		}

		auto get_default_priority_targets(const unit_t* u, int min_distance, int max_distance) const {
			xy pos = u->sprite->position;
			rect bounds{ { pos.x - max_distance - 64, pos.y - max_distance - 64 }, { pos.x + max_distance + 64, pos.y + max_distance + 64 } };
			const unit_t* main_unit = unit_main_unit(u);
			const unit_t* attacking_unit = unit_attacking_unit(u);
			bool can_turn = u_can_turn(attacking_unit);
			std::array<std::deque<unit_t*>, 6> targets{};
			for (unit_t* target : find_units_noexpand(bounds)) {
				if (target == u) continue;
				if (!unit_target_is_enemy(u, target)) continue;
				if (!unit_target_is_visible(u, target)) continue;
				if (!unit_can_attack_target(u, target)) continue;
				int distance = units_distance(main_unit, target);
				if (distance > max_distance) continue;
				if (min_distance && distance <= min_distance) continue;
				if (!can_turn) {
					if (!unit_target_in_attack_angle(attacking_unit, target->sprite->position, attacking_unit->unit_type->ground_weapon)) continue;
				}
				int prio = unit_target_attack_priority(u, target);
				if (targets[prio].size() < 0x10) targets[prio].push_back(target);
			}
			return targets;
		}

		unit_t* find_acquire_target(const unit_t* u) const {
			int acq_range = unit_target_acquisition_range(u);
			if (u_in_bunker(u)) acq_range += 2;

			int min_distance = 0;
			int max_distance = acq_range * 32;

			auto* ground_weapon = unit_or_subunit_ground_weapon(u);
			auto* air_weapon = unit_or_subunit_air_weapon(u);
			if (ground_weapon) {
				if (!air_weapon) min_distance = ground_weapon->min_range;
				else min_distance = std::min(ground_weapon->min_range, air_weapon->min_range);
			}
			else {
				if (air_weapon) min_distance = air_weapon->min_range;
			}
			auto targets = get_default_priority_targets(u, min_distance, max_distance);
			for (auto& v : targets) {
				if (v.empty()) continue;
				return *get_best_score(v, [&](const unit_t* target) {
					return xy_length(target->sprite->position - u->sprite->position);
					});
			}
			return nullptr;
		}

		void order_PlayerGuard(unit_t* u) {
			if (!unit_autoattack(u)) {
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					if (ut_turret(u)) {
						set_next_target_waypoint(u, u->subunit->next_target_waypoint);
					}
					if (unit_target_acquisition_range(u) != 0) {
						unit_t* target = find_acquire_target(u);
						if (target) auto_attack_target(u, target);
					}
				}
			}
		}

		void order_TurretGuard(unit_t* u) {
			set_next_target_waypoint(u, u->subunit->next_target_waypoint);
			order_PlayerGuard(u);
		}

		bool unit_pos_is_bordering_target(const unit_t* u, xy pos, const unit_t* target) {
			auto bb = unit_sprite_inner_bounding_box(target);
			bb.from -= u->unit_type->dimensions.to + xy(1, 1);
			bb.to.x += u->unit_type->dimensions.from.x + 1;
			// This is an original bug. Don't fix
			bb.to.x += u->unit_type->dimensions.from.y + 1;
			if (pos.x == bb.from.x || pos.x == bb.to.x) {
				if (pos.y >= bb.from.y && pos.y <= bb.to.y) {
					return true;
				}
			}
			else if (pos.y == bb.from.y || pos.y == bb.to.y) {
				if (pos.x >= bb.from.x && pos.x <= bb.to.x) {
					return true;
				}
			}
			return false;
		}

		void move_to_target(unit_t* u, unit_t* target) {
			if (u->move_target.unit == target && (u->move_target.pos == target->sprite->position || unit_pos_is_bordering_target(u, u->move_target.pos, target))) {
				u_unset_status_flag(u, unit_t::status_flag_immovable);
			}
			else {
				set_unit_move_target(u, target);
			}
		}

		void move_to_target_reset(unit_t* u, unit_t* target) {
			move_to_target(u, target);
			set_next_target_waypoint(u, target->sprite->position);
		}

		void order_Move(unit_t* u) {
			if (u->order_state == 0) {
				if (u->order_target.unit) {
					move_to_target_reset(u, u->order_target.unit);
				}
				else {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
				}
				u->order_state = 1;
			}
			else {
				if (unit_is_at_move_target(u)) {
					order_done(u);
				}
			}
		}

		void order_Nothing(unit_t* u) {
			if (!u->order_queue.empty()) {
				activate_next_order(u);
			}
		}

		void set_unit_gathering(unit_t* u) {
			if (u_gathering(u)) return;
			u_set_status_flag(u, unit_t::status_flag_gathering);
			queue_order_front(u, get_order_type(Orders::ResetHarvestCollision), {});
		}

		template<typename F>
		unit_t* find_nearest_unit(xy pos, rect search_area, F&& predicate) const {
			// TODO: Rewrite Factorio
			return nullptr;
		}

		template<typename F>
		unit_t* find_nearest_unit(const unit_t* u, rect search_area, F&& predicate) const {
			// TODO: Rewrite Factorio
			return nullptr;
		}

		bool unit_is_mineral_field(unit_type_autocast ut) const {
			if (ut->id == UnitTypes::Resource_Mineral_Field) return true;
			if (ut->id == UnitTypes::Resource_Mineral_Field_Type_2) return true;
			if (ut->id == UnitTypes::Resource_Mineral_Field_Type_3) return true;
			return false;
		}

		bool any_neighbor_tile_unoccupied(const unit_t* u) const {
			// TODO
			return false;
		}

		bool unit_position_is_explored(const unit_t* u, xy position) const {
			return (st.tiles[tile_index(position)].explored & (1 << u->owner)) == 0;
		}

		int long_path_distance(xy from, xy to) const {
			// TODO: Factorio pathing
			return 0;
		}

		int unit_long_path_distance(const unit_t* u, xy from, xy to) const {
			if (~u->pathing_flags & 1) return xy_length(to - from);
			return long_path_distance(from, to);
		}

		void order_MoveToMinerals(unit_t* u) {
			if (u->carrying_flags && (u->carrying_flags & 3) == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
			set_unit_gathering(u);

			auto find_mineral_field = [&](xy pos, int range, bool require_not_being_gathered) {
				rect area{ pos - xy(range, range), pos + xy(range, range) };
				int ground_height = get_ground_height_at(pos);
				return find_nearest_unit(pos, area, [&](const unit_t* target) {
					if (!unit_is_mineral_field(target)) return false;
					if (!any_neighbor_tile_unoccupied(target)) return false;
					if (!is_reachable(u->sprite->position, target->sprite->position)) return false;
					if (get_ground_height_at(target->sprite->position) != ground_height) return false;
					if (!unit_position_is_explored(u, target->sprite->position)) return false;
					if (unit_long_path_distance(target, target->sprite->position, u->sprite->position) > 2 * range) return false;
					if (require_not_being_gathered && target->building.resource.is_being_gathered) return false;
					return true;
					});
			};

			unit_t* target = u->order_target.unit;
			if (!target || !unit_is_mineral_field(target)) {
				xy search_pos = u->sprite->position;
				if (u->worker.target_resource_position != xy()) {
					search_pos = u->worker.target_resource_position;
					u->worker.target_resource_position = {};
				}
				target = find_mineral_field(search_pos, 32 * 12, false);
				if (!target) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					order_done(u);
					return;
				}
				u->order_target.pos = target->sprite->position;
				u->order_target.unit = target;
				u->order_state = 0;
			}
			if (u->order_state == 0) {
				move_to_target_reset(u, u->order_target.unit);
				u->worker.target_resource_position = u->order_target.pos;
				u->worker.target_resource_unit = u->order_target.unit;
				u->order_state = 1;
			}
			else {
				if (u->order_state == 1) {
					if (!unit_target_in_range(u, target, 10) && !unit_is_at_move_target(u)) return;
					if (target->building.resource.is_being_gathered) {
						unit_t* new_target = find_mineral_field(u->sprite->position, 32 * 8, true);
						if (new_target) {
							move_to_target_reset(u, new_target);
							u->worker.target_resource_position = new_target->sprite->position;
							u->worker.target_resource_unit = new_target;
							u->order_target.unit = new_target;
							u->order_target.pos = new_target->sprite->position;
							return;
						}
					}
					u->order_state = 3;
				}
				if (u->order_state == 3) {
					if (unit_is_at_move_target(u)) {
						if (u_immovable(u)) {
							target = find_mineral_field(u->sprite->position, 32 * 12, false);
							if (target) {
								move_to_target_reset(u, target);
								u->worker.target_resource_position = target->sprite->position;
								u->worker.target_resource_unit = target;
								u->order_target.unit = target;
								u->order_target.pos = target->sprite->position;
							}
							else order_done(u);
						}
						else {
							if (u->carrying_flags & 2) {
								set_unit_order(u, get_order_type(Orders::ReturnMinerals));
							}
							else {
								set_next_target_waypoint(u, u->order_target.pos);
								order_target_t order_target;
								order_target.position = target->sprite->position;
								order_target.unit = target;
								queue_order_front(u, get_order_type(Orders::WaitForMinerals), order_target);
								order_done(u);
							}
						}
					}
				}
			}
		}

		void wait_for_resource(unit_t* u, unit_t* target) {
			u->order_process_timer = 0;
			u->order_state = 2;
			if (!try_gather_resource(u, target)) {
				if (!u->worker.gather_target) {
					u->worker.gather_target = target;
					target->building.resource.gather_queue.push_front(*u);
				}
				queue_order_front(u, get_order_type(Orders::GatherWaitInterrupted), {});
			}
		}

		void order_WaitForMinerals(unit_t* u) {
			if (u->order_target.unit && unit_is_mineral_field(u->order_target.unit)) {
				if (u->order_state == 0) {
					wait_for_resource(u, u->order_target.unit);
				}
			}
			else {
				set_unit_order(u, get_order_type(Orders::MoveToMinerals));
			}
		}

		bool is_facing_next_target_waypoint(const unit_t* u, fp8 angle = 0_fp8) const {
			if (u->position == u->next_target_waypoint) return true;
			if (fp8::extend(u->heading - xy_direction(u->next_target_waypoint - u->sprite->position)).abs() <= angle) return true;
			return false;
		}

		void set_unit_resources(unit_t* u, int resources) {
			if (!ut_resource(u)) return;
			u->building.resource.resource_count = resources;
			if (unit_is_mineral_field(u)) {
				int anim = iscript_anims::WorkingToIdle;
				if (resources < 250) anim = iscript_anims::SpecialState1;
				else if (resources < 500) anim = iscript_anims::SpecialState2;
				else if (resources < 750) anim = iscript_anims::AlmostBuilt;
				if (u->building.resource.resource_iscript != anim) {
					u->building.resource.resource_iscript = anim;
					sprite_run_anim(u->sprite, anim);
				}
			}
		}

		void destroy_carrying_images(const unit_t* u) {
			destroy_image_from_to(u->sprite, ImageTypes::IMAGEID_Mineral_Chunk_Shadow, ImageTypes::IMAGEID_Psi_Emitter_Shadow_Carried);
			destroy_image_from_to(u->sprite, ImageTypes::IMAGEID_Flag, ImageTypes::IMAGEID_Terran_Gas_Tank_Type2);
			destroy_image_from_to(u->sprite, ImageTypes::IMAGEID_Uraj, ImageTypes::IMAGEID_Khalis);
		}

		void unit_gather_resources_from(unit_t* u, unit_t* resource) {
			const image_type_t* image_type = nullptr;
			bool is_minerals = false;
			switch (resource->unit_type->id) {
			case UnitTypes::Terran_Refinery:
				image_type = get_image_type(ImageTypes::IMAGEID_Terran_Gas_Tank_Type1);
				break;
			case UnitTypes::Protoss_Assimilator:
				image_type = get_image_type(ImageTypes::IMAGEID_Protoss_Gas_Orb_Type1);
				break;
			case UnitTypes::Zerg_Extractor:
				image_type = get_image_type(ImageTypes::IMAGEID_Zerg_Gas_Sac_Type1);
				break;
			case UnitTypes::Resource_Mineral_Field:
			case UnitTypes::Resource_Mineral_Field_Type_2:
			case UnitTypes::Resource_Mineral_Field_Type_3:
				image_type = get_image_type(ImageTypes::IMAGEID_Mineral_Chunk_Type1);
				is_minerals = true;
				break;
			default:
				break;
			}
			if (!image_type) return;
			int gathered = 0;
			if (resource->building.resource.resource_count < 8) {
				image_type = get_image_type((ImageTypes)((int)image_type->id + 1));
				if (is_minerals) {
					gathered = resource->building.resource.resource_count;
					kill_unit(resource);
				}
				else {
					resource->building.resource.resource_count = 0;
					gathered = 2;
				}
			}
			else {
				set_unit_resources(resource, resource->building.resource.resource_count - 8);
				gathered = 8;
				if (is_minerals) {
					if (resource->building.resource.resource_count == 0) {
						kill_unit(resource);
					}
				}
			}
			if (gathered) {
				if (u->carrying_flags & 3) {
					destroy_carrying_images(u);
					u->carrying_flags = 0;
				}
				if (u->carrying_flags == 0) {
					if (is_minerals) u->carrying_flags = 2;
					else u->carrying_flags = 1;
					u->worker.resources_carried = gathered;
					// TODO
					//image_t* image = create_image(image_type, u->sprite, {}, image_order_above);
					image_t* image = nullptr;
					if (image) {
						if (!i_flag(image, image_t::flag_uses_special_offset)) {
							i_set_flag(image, image_t::flag_uses_special_offset);
							update_image_special_offset(image);
						}
					}
				}
			}
		}

		void gather_queue_next(unit_t* u, unit_t* resource) {
			u->worker.is_gathering = false;
			u->worker.gather_target = nullptr;
			if (resource) {
				resource->building.resource.is_being_gathered = false;
				unit_t* next_unit = nullptr;
				for (unit_t* queued_unit : reverse(ptr(resource->building.resource.gather_queue))) {
					if (!unit_is_disabled(queued_unit)) {
						if (queued_unit->order_type->id == Orders::WaitForGas || queued_unit->order_type->id == Orders::WaitForMinerals) {
							next_unit = queued_unit;
							break;
						}
					}
				}
				if (next_unit) {
					next_unit->worker.gather_target = nullptr;
					resource->building.resource.gather_queue.remove(*next_unit);
					remove_one_order(next_unit, get_order_type(Orders::GatherWaitInterrupted));
					try_gather_resource(next_unit, resource);
				}
			}
		}

		void order_MiningMinerals(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (target && unit_is_mineral_field(target)) {
				set_unit_gathering(u);
				if (u->order_state == 0) {
					if (is_facing_next_target_waypoint(u)) {
						u->order_target.pos = u->sprite->position + to_xy(direction_xy(u->heading, fp8::integer(20)));
						sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
						u->main_order_timer = 75;
						u->order_state = 5;
					}
				}
				else if (u->order_state == 5) {
					if (u->main_order_timer == 0) {
						sprite_run_anim(u->sprite, iscript_anims::GndAttkToIdle);
						unit_gather_resources_from(u, target);
						gather_queue_next(u, target);
						remove_one_order(u, get_order_type(Orders::GatheringInterrupted));
						if (u->carrying_flags & 2) {
							set_unit_order(u, get_order_type(Orders::ReturnMinerals));
						}
						else {
							set_unit_order(u, get_order_type(Orders::MoveToMinerals));
						}
					}
				}
			}
			else {
				if (u->worker.is_gathering) {
					gather_queue_next(u, u->worker.gather_target);
				}
				remove_one_order(u, get_order_type(Orders::GatheringInterrupted));
				set_unit_order(u, get_order_type(Orders::MoveToMinerals));
			}
		}

		void order_ResetHarvestCollision(unit_t* u) {
			if (!u->order_queue.empty()) {
				order_t* next_order = &u->order_queue.front();
				auto nid = next_order->order_type->id;
				switch (nid) {
				case Orders::Harvest1:
				case Orders::MoveToGas:
				case Orders::WaitForGas:
				case Orders::HarvestGas:
				case Orders::MoveToMinerals:
				case Orders::WaitForMinerals:
				case Orders::MiningMinerals:
				case Orders::GatheringInterrupted:
				case Orders::GatherWaitInterrupted:
					while (u->order_queue.back().order_type->id == Orders::ResetHarvestCollision) {
						remove_queued_order(u, &u->order_queue.back());
					}
					queue_order_back(u, get_order_type(Orders::ResetHarvestCollision), {});
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
					return;
				default: break;
				}
			}
			u_unset_status_flag(u, unit_t::status_flag_gathering);
			u_unset_status_flag(u, unit_t::status_flag_no_collide);
			check_unit_collision(u);
			if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
			reset_movement_state(u);
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_ReturnGas(unit_t* u) {
			order_ReturnMinerals(u);
		}

		bool unit_type_is_morphing_building(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Zerg_Hive)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Lair)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Greater_Spire)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Spore_Colony)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Sunken_Colony)) return true;
			return false;
		}

		bool unit_is_morphing_building(const unit_t* u) const {
			if (u_completed(u)) return false;
			if (u->build_queue.empty()) return false;
			return unit_type_is_morphing_building(u->build_queue.front());
		}

		bool ut_resource_depot(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_resource_depot);
		}
		bool unit_is_active_resource_depot(const unit_t* u) const {
			if (!u_grounded_building(u)) return false;
			if (!ut_resource_depot(u)) return false;

			if (u_completed(u)) return true;
			if (unit_is(u, UnitTypes::Zerg_Hive)) return true;
			if (unit_is(u, UnitTypes::Zerg_Lair)) return true;
			if (unit_is(u, UnitTypes::Zerg_Hatchery) && unit_is_morphing_building(u)) return true;
			return false;
		}

		unit_t* find_nearest_active_resource_depot(const unit_t* u) const {
			// TODO: Factorio search
			/*return find_nearest_unit(u, map_bounds(), [&](const unit_t* target) {
				if (target == u) return false;
				if (!unit_is_active_resource_depot(target)) return false;
				if (target->owner != u->owner) return false;
				if (~u->pathing_flags & 1 || !is_reachable(u->sprite->position, target->sprite->position)) return false;
				return true;
				});*/
			return nullptr;
		}

		bool unit_is_hatchery(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Zerg_Hatchery)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Lair)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Hive)) return true;
			return false;
		}

		void order_ReturnMinerals(unit_t* u) {
			if ((u->carrying_flags & 3) == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
			set_unit_gathering(u);
			unit_t* target = u->order_target.unit;
			if (!target || !unit_is_active_resource_depot(target)) {
				target = nullptr;
				u->order_state = 0;
			}
			if (u->order_state == 0) {
				if (!target) target = find_nearest_active_resource_depot(u);
				if (target) {
					u->order_target.unit = target;
					move_to_target_reset(u, target);
					u->order_state = 1;
				}
				else {
					u->order_process_timer = 75;
				}
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (u_immovable(u)) {
						u->order_target.unit = nullptr;
						u->order_state = 0;
					}
					else {
						const order_type_t* next_order_type = nullptr;
						if (u->carrying_flags & 1) next_order_type = get_order_type(Orders::MoveToGas);
						else next_order_type = get_order_type(Orders::MoveToMinerals);
						if (u->worker.target_resource_unit) {
							queue_order_front(u, next_order_type, u->worker.target_resource_unit);
						}
						else {
							queue_order_front(u, next_order_type, {});
						}
						order_done(u);
						destroy_carrying_images(u);
						u->carrying_flags = 0;
						u->worker.resources_carried = 0;

						if (unit_is_hatchery(target)) {
							for (auto& v : target->building.hatchery.larva_spawn_side_values) {
								if (v) --v;
							}
							auto bb = unit_sprite_inner_bounding_box(target);
							int* val;
							if (u->sprite->position.y < bb.from.y) {
								val = &target->building.hatchery.larva_spawn_side_values[1];
							}
							else if (u->sprite->position.y > bb.to.y) {
								val = &target->building.hatchery.larva_spawn_side_values[3];
							}
							else if (u->sprite->position.x < bb.from.x) {
								val = &target->building.hatchery.larva_spawn_side_values[0];
							}
							else {
								val = &target->building.hatchery.larva_spawn_side_values[2];
							}
							if (*val < 100) *val += 25;
						}
					}
				}
			}
		}

		bool unit_is_factory(const unit_t* u) const {
			if (unit_is(u, UnitTypes::Terran_Command_Center)) return true;
			if (unit_is(u, UnitTypes::Terran_Barracks)) return true;
			if (unit_is(u, UnitTypes::Terran_Factory)) return true;
			if (unit_is(u, UnitTypes::Terran_Starport)) return true;
			if (unit_is(u, UnitTypes::Zerg_Infested_Command_Center)) return true;
			if (unit_is(u, UnitTypes::Zerg_Hatchery)) return true;
			if (unit_is(u, UnitTypes::Zerg_Lair)) return true;
			if (unit_is(u, UnitTypes::Zerg_Hive)) return true;
			if (unit_is(u, UnitTypes::Protoss_Nexus)) return true;
			if (unit_is(u, UnitTypes::Protoss_Gateway)) return true;
			if (unit_is(u, UnitTypes::Protoss_Stargate)) return true;
			if (unit_is(u, UnitTypes::Protoss_Robotics_Facility)) return true;
			return false;
		}

		void remove_target_references(unit_t* u, const unit_t* target) {
			auto test = [&](auto*& ref) {
				if (ref == target) {
					ref = nullptr;
					return true;
				}
				else return false;
			};
			test(u->current_build_unit);
			test(u->order_target.unit);
			test(u->move_target.unit);
			test(u->auto_target_unit);
			test(u->connected_unit);
			test(u->irradiated_by);
			if (ut_worker(u)) {
				test(u->worker.target_resource_unit);
				if (u->worker.is_gathering && test(u->worker.gather_target)) {
					u->worker.is_gathering = false;
				}
			}
			if (u_grounded_building(u)) {
				test(u->building.addon);
			}
			if (unit_turret(u)) remove_target_references(unit_turret(u), target);
			for (auto i = u->order_queue.begin(); i != u->order_queue.end();) {
				order_t* o = &*i++;
				if (o->target.unit == target) {
					remove_queued_order(u, o);
				}
			}
		}

		void tiles_flags_and(size_t offset_x, size_t offset_y, size_t width, size_t height, int flags) {
			// TODO
		}
		void remove_target_references(bullet_t* b, const unit_t* target) {
			if (b->bullet_target == target) b->bullet_target = nullptr;
			if (b->bullet_owner_unit == target) b->bullet_owner_unit = nullptr;
		}

		void set_unit_tiles_unoccupied(unit_type_autocast ut, xy position) {
			xy size(ut->placement_size.x / 32u, ut->placement_size.y / 32u);
			xy pos(position.x / 32u, position.y / 32u);
			tiles_flags_and(pos.x - size.x / 2, pos.y - size.y / 2, size.x, size.y, ~tile_t::flag_occupied);
		}

		void set_sprite_visibility(sprite_t* sprite, int visibility_flags) {
			if (sprite->visibility_flags == visibility_flags) return;
			sprite->visibility_flags = visibility_flags;
		}

		void hide_unit(unit_t* u) {
			if (us_hidden(u)) return;
			for (unit_t* n : ptr(st.visible_units)) {
				remove_target_references(n, u);
			}
			for (bullet_t* n : ptr(st.active_bullets)) {
				remove_target_references(n, u);
			}
			//unit_finder_remove(u);
			if (u_grounded_building(u)) set_unit_tiles_unoccupied(u, u->sprite->position);
			if (u_flying(u)) decrement_repulse_field(u);
			reset_movement_state(u);
			st.visible_units.remove(*u);
			bw_insert_list(st.hidden_units, *u);

			u->sprite->flags |= sprite_t::flag_hidden;
			set_sprite_visibility(u->sprite, 0);
			unit_t* turret = unit_turret(u);
			if (turret) {
				turret->sprite->flags |= sprite_t::flag_hidden;
				set_sprite_visibility(turret->sprite, 0);
			}
		}

		void order_Die(unit_t* u) {
			// TODO: Just kill in factorio
		}

		void remove_unit(unit_t* u) {
			// TODO: Just remove in factorio
		}

		void order_GatherWaitInterrupted(unit_t* u) {
			if (u->worker.gather_target) {
				u->worker.gather_target->building.resource.gather_queue.remove(*u);
				u->worker.gather_target = nullptr;
			}
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_GatheringInterrupted(unit_t* u) {
			if (u->worker.is_gathering) {
				gather_queue_next(u, u->worker.gather_target);
			}
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		const unit_type_t* get_unit_type(UnitTypes id) const {
			return &game_st.unit_types.vec[(size_t)id];
		}
		bool ut_two_units_in_one_egg(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_two_units_in_one_egg);
		}
		bool has_available_supply_for(int owner, const unit_type_t* unit_type) const {
			if (ut_flag(unit_type, (unit_type_t::flags_t)0x1000000)) return true;
			auto supply_required = unit_type->supply_required;
			if (ut_two_units_in_one_egg(unit_type)) supply_required *= 2;
			if (supply_required == fp1::zero()) return true;
			if (unit_type->id == UnitTypes::Zerg_Lurker) {
				supply_required -= get_unit_type(UnitTypes::Zerg_Hydralisk)->supply_required;
			}
			auto race = unit_race(unit_type);
			if (race == race_t::none) return false;
			size_t index = (size_t)race;
			if (st.supply_used[owner][index] + supply_required > fp1::integer(200)) {
				return false;
			}
			if (st.supply_used[owner][index] + supply_required > st.supply_available[owner][index]) {
				return false;
			}
			return true;
		}

		bool player_has_supply_and_resources_for(int owner, const unit_type_t* unit_type) {
			// TODO: Assume no resource restrictions for now
			return has_available_supply_for(owner, unit_type);
		}

		bool unit_is_refinery(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Refinery)) return true;
			if (unit_is(ut, UnitTypes::Protoss_Assimilator)) return true;
			if (unit_is(ut, UnitTypes::Zerg_Extractor)) return true;
			return false;
		}

		unit_t* get_building_at_center_position(xy pos, const unit_type_t* unit_type) const {
			for (unit_t* n : find_units_noexpand({ pos, pos + xy(game_st.max_unit_width, game_st.max_unit_height) })) {
				if (n->unit_type == unit_type && n->sprite->position / 32 == pos / 32) {
					return n;
				}
			}
			return nullptr;
		}

		bool unit_is_nydus(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Zerg_Nydus_Canal);
		}

		bool ut_requires_creep(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_requires_creep);
		}

		bool ut_addon(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_addon);
		}

		bool is_reachable(const unit_t* u, xy to) const {
			if (~u->pathing_flags & 1) return true;
			return is_reachable(u->sprite->position, to);
		}

		bool can_place_building(const unit_t* u, int owner, const unit_type_t* unit_type, xy pos, bool check_undetected_units, bool check_invisible_tiles) const {
			xy_t<size_t> tile_pos;
			tile_pos.x = (pos.x - unit_type->placement_size.x / 2) / 32u;
			tile_pos.y = (pos.y - unit_type->placement_size.y / 2) / 32u;
			xy_t<size_t> tile_size;
			tile_size.x = unit_type->placement_size.x / 32u;
			tile_size.y = unit_type->placement_size.y / 32u;
			if (u && !u_flying(u) && !u_grounded_building(u) && !is_reachable(u, xy(int(tile_pos.x * 32), int(tile_pos.y * 32)))) return false;

			int visibility_mask = 1 << owner;

			if (unit_is_refinery(unit_type)) {
				xy gas_placement_size = get_unit_type(UnitTypes::Resource_Vespene_Geyser)->placement_size;
				tile_size.x = gas_placement_size.x / 32u;
				tile_size.y = gas_placement_size.y / 32u;

				xy gas_pos(int(tile_pos.x * 32), int(tile_pos.y * 32));
				gas_pos += gas_placement_size / 2;
				return get_building_at_center_position(gas_pos, get_unit_type(UnitTypes::Resource_Vespene_Geyser)) != nullptr;
			}

			// TODO: Psi Matrix/Pylon power requirements

			// TODO: Factorio: `surface.can_place_entity` for the remaining logic
			return true;
		}

		//void add_completed_unit(unit_t* u, int count, bool increment_score) {
		//	// TODO: Use Factorio counts
		//}
		//
		//void increment_unit_counts(unit_t* u, int count) {
		//	// TODO: Use Factorio counts
		//
		//	// TODO Also supply management
		//}

		unit_t* unit_attacking_unit(unit_t* u) const {
			return u->subunit && ut_turret(u->subunit) ? u->subunit : u;
		}

		bool u_cooldown_upgrade(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_cooldown_upgrade);
		}
		void update_unit_speed_upgrades(unit_t* u) {
			auto speed_upgrade = [&]() {
				switch (u->unit_type->id) {
				case UnitTypes::Terran_Vulture:
				case UnitTypes::Hero_Jim_Raynor_Vulture:
					return UpgradeTypes::Ion_Thrusters;
				case UnitTypes::Zerg_Overlord:
					return UpgradeTypes::Pneumatized_Carapace;
				case UnitTypes::Zerg_Zergling:
					return UpgradeTypes::Metabolic_Boost;
				case UnitTypes::Zerg_Hydralisk:
					return UpgradeTypes::Muscular_Augments;
				case UnitTypes::Protoss_Zealot:
					return UpgradeTypes::Leg_Enhancements;
				case UnitTypes::Protoss_Scout:
					return UpgradeTypes::Gravitic_Thrusters;
				case UnitTypes::Protoss_Shuttle:
					return UpgradeTypes::Gravitic_Drive;
				case UnitTypes::Protoss_Observer:
					return UpgradeTypes::Gravitic_Boosters;
				case UnitTypes::Zerg_Ultralisk:
					return UpgradeTypes::Anabolic_Synthesis;
				default:
					return UpgradeTypes::None;
				};
			};
			bool cooldown = false;
			if (unit_is(u, UnitTypes::Hero_Devouring_One)) cooldown = true;
			if (unit_is(u, UnitTypes::Zerg_Zergling) && player_has_upgrade(u->owner, UpgradeTypes::Adrenal_Glands)) cooldown = true;
			bool speed = false;
			auto speed_upg = speed_upgrade();
			if (speed_upg != UpgradeTypes::None && player_has_upgrade(u->owner, speed_upg)) speed = true;
			if (unit_is(u, UnitTypes::Hero_Hunter_Killer)) speed = true;
			if (unit_is(u, UnitTypes::Hero_Yggdrasill)) speed = true;
			if (unit_is(u, UnitTypes::Hero_Fenix_Zealot)) speed = true;
			if (unit_is(u, UnitTypes::Hero_Mojo)) speed = true;
			if (unit_is(u, UnitTypes::Hero_Artanis)) speed = true;
			if (unit_is(u, UnitTypes::Zerg_Lurker)) speed = true;
			if (cooldown != u_cooldown_upgrade(u) || speed != u_speed_upgrade(u)) {
				if (cooldown) u->status_flags |= unit_t::status_flag_cooldown_upgrade;
				if (speed) u->status_flags |= unit_t::status_flag_speed_upgrade;
				update_unit_speed(u);
			}
		}

		void set_unit_owner(unit_t* u, int owner, bool increment_score) {
			// TODO: Use factorio entity ownership
			// Kill order targetting stuff

			if (u->order_target.unit && u->order_type->targets_enemies && !unit_target_is_enemy(u, u->order_target.unit)) {
				u->order_target.unit = nullptr;
			}
			for (unit_t* n : ptr(st.visible_units)) {
				n = unit_attacking_unit(n);
				if (n->order_target.unit == u && n->order_type->targets_enemies && !unit_target_is_enemy(n, u)) {
					n->order_target.unit = nullptr;
				}
			}
			for (unit_t* n : ptr(st.hidden_units)) {
				n = unit_attacking_unit(n);
				if (n->order_target.unit == u && n->order_type->targets_enemies && !unit_target_is_enemy(n, u)) {
					n->order_target.unit = nullptr;
				}
			}
			unit_t* turret = unit_turret(u);
			if (turret) set_unit_owner(u->subunit, owner, increment_score);
			update_unit_speed_upgrades(u);
			if (ut_worker(u) && u->worker.gather_target && unit_is(u->worker.gather_target, UnitTypes::Powerup_Flag)) {
				if (owner >= 8 || owner == u->worker.gather_target->owner) drop_carried_items(u);
			}
		}

		void set_sprite_owner(unit_t* u, int owner) {
			// TODO meh
		}

		bool initialize_flingy(flingy_t* f, const flingy_type_t* flingy_type, xy pos, int owner, direction_t heading) {
			f->flingy_type = flingy_type;
			f->movement_flags = 0;
			f->next_speed = 0_fp8;
			f->flingy_top_speed = flingy_type->top_speed;
			f->flingy_acceleration = flingy_type->acceleration;
			f->flingy_turn_rate = flingy_type->turn_rate;
			f->flingy_movement_type = flingy_type->movement_type;

			f->position = pos;
			f->exact_position = to_xy_fp8(pos);

			set_flingy_move_target(f, pos);
			set_next_target_waypoint(f, pos);
			f->heading = heading;
			f->next_velocity_direction = heading;
			f->hp = 1_fp8;

			// TODO
			//f->sprite = create_sprite(flingy_type->sprite, pos, owner);
			if (!f->sprite) return false;
			auto dir = f->heading;
			// TODO: Image heading/direction

			return true;
		}

		bool ut_flyer(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_flyer);
		}
		bool ut_can_turn(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_can_turn);
		}
		bool ut_can_move(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_can_move);
		}

		bool unit_is_vulture(unit_type_autocast ut) const {
			return unit_is(ut, UnitTypes::Terran_Vulture) || unit_is(ut, UnitTypes::Hero_Jim_Raynor_Vulture);
		}

		bool unit_is_fighter(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Protoss_Interceptor)) return true;
			if (unit_is(ut, UnitTypes::Protoss_Scarab)) return true;
			return false;
		}

		bool initialize_unit_type(unit_t* u, const unit_type_t* unit_type, xy pos, int owner) {

			auto ius = make_thingy_setter(iscript_unit, u);
			if (!initialize_flingy(u, unit_type->flingy, pos, owner, 0_dir)) return false;

			u->owner = owner;
			u->order_type = get_order_type(Orders::Fatal);
			u->order_state = 0;
			u->order_signal = 0;
			u->order_unit_type = nullptr;
			u->main_order_timer = 0;
			u->ground_weapon_cooldown = 0;
			u->air_weapon_cooldown = 0;
			u->spell_cooldown = 0;
			u->order_target = {};
			u->unit_type = unit_type;
			u->carrying_flags = 0;
			u->secondary_order_timer = 0;

			if (!iscript_execute_sprite(u->sprite)) {
				u->sprite = nullptr;
				return false;
			}
			u->last_attacking_player = 8;
			//u->shield_points = fp8::integer(u->unit_type->shield_points);
			if (unit_is(u, UnitTypes::Protoss_Shield_Battery)) u->energy = fp8::integer(100);
			else u->energy = unit_max_energy(u) / 4;

			u->sprite->elevation_level = unit_type->elevation_level;
			u_set_status_flag(u, unit_t::status_flag_grounded_building, ut_building(u));
			u_set_status_flag(u, unit_t::status_flag_flying, ut_flyer(u));
			u_set_status_flag(u, unit_t::status_flag_can_turn, ut_can_turn(u));
			u_set_status_flag(u, unit_t::status_flag_can_move, ut_can_move(u));
			u_set_status_flag(u, unit_t::status_flag_ground_unit, !ut_flyer(u));
			if (u->unit_type->elevation_level < 12) u->pathing_flags |= 1;
			else u->pathing_flags &= ~1;
			u->building.addon = nullptr;
			u->building.addon_build_type = nullptr;
			u->building.upgrade_research_time = 0;
			u->building.researching_type = nullptr;
			u->building.upgrading_type = nullptr;
			u->building.larva_timer = 0;
			u->building.is_landing = false;
			u->building.creep_timer = 0;
			u->building.upgrading_level = 0;
			bool building_union_used = false;
			if (ut_resource(u)) {
				building_union_used = true;
				u->building.resource.resource_count = 0;
				u->building.resource.resource_iscript = 0;
				u->building.resource.is_being_gathered = false;
				u->building.resource.gather_queue.clear();
			}
			if (unit_is(u, UnitTypes::Terran_Nuclear_Silo)) {
				building_union_used = true;
				u->building.silo = {};
			}
			if (unit_is_hatchery(u)) {
				building_union_used = true;
				u->building.hatchery.larva_spawn_side_values = {};
			}
			if (unit_is_nydus(u)) {
				building_union_used = true;
				u->building.nydus.exit = nullptr;
			}
			bool unit_union_used = false;
			if (unit_is_ghost(u)) {
				unit_union_used = true;
				u->ghost.nuke_dot = nullptr;
			}
			if (unit_is_vulture(u)) {
				unit_union_used = true;
				u->vulture.spider_mine_count = 0;
			}
			if (unit_is_carrier(u)) {
				unit_union_used = true;
				u->carrier.inside_units.clear();
				u->carrier.outside_units.clear();
				u->carrier.inside_count = 0;
				u->carrier.outside_count = 0;
			}
			if (unit_is_reaver(u)) {
				unit_union_used = true;
				u->reaver.inside_units.clear();
				u->reaver.outside_units.clear();
				u->reaver.inside_count = 0;
				u->reaver.outside_count = 0;
			}
			if (unit_is_fighter(u)) {
				unit_union_used = true;
				u->fighter.parent = nullptr;
				u->fighter.fighter_link = { nullptr, nullptr };
				u->fighter.is_outside = false;
			}

			if (ut_worker(u)) {
				u->worker.powerup = nullptr;
				u->worker.target_resource_position = {};
				u->worker.target_resource_unit = nullptr;
				u->worker.repair_timer = 0;
				u->worker.is_gathering = false;
				u->worker.resources_carried = 0;
				u->worker.gather_target = nullptr;
			}

			u->path = nullptr;
			u->movement_state = movement_states::UM_Init;
			u->move_target_timer = 0;
			u_set_status_flag(u, unit_t::status_flag_invincible, ut_invincible(u));

			if (u->unit_type->build_time == 0) {
				u->remaining_build_time = 1;
				u->hp_construction_rate = 1_fp8;
			}
			else {
				u->remaining_build_time = u->unit_type->build_time;
				u->hp_construction_rate = (u->unit_type->hitpoints - u->unit_type->hitpoints / 10 + fp8::from_raw(u->unit_type->build_time) - 1_fp8) / u->unit_type->build_time;
				if (u->hp_construction_rate == 0_fp8) u->hp_construction_rate = 1_fp8;
			}
			update_unit_speed_upgrades(u);
			update_unit_speed(u);

			return true;
		}

		void reinitialize_unit_type(unit_t* u, const unit_type_t* unit_type) {
			if (ut_worker(u) && u->worker.gather_target) {
				if (u->worker.is_gathering) {
					gather_queue_next(u, u->worker.gather_target);
				}
				else {
					u->worker.gather_target->building.resource.gather_queue.remove(*u);
					u->worker.gather_target = nullptr;
				}
			}
			xy position = u->sprite->position;
			auto prev_unit_type = u->unit_type;
			auto prev_hp = u->hp;
			auto prev_order_type = u->order_type;
			auto prev_order_target = u->order_target;
			auto prev_order_state = u->order_state;
			auto prev_sprite_owner = u->sprite->owner;
			int prev_resources = ut_resource(u) ? u->building.resource.resource_count : 0;
			std::array<int, 4> prev_larva_spawn_side_values;
			bool was_hatchery = unit_is_hatchery(u);
			if (was_hatchery) prev_larva_spawn_side_values = u->building.hatchery.larva_spawn_side_values;
			u->previous_unit_type = prev_unit_type;
			u->previous_hp = std::max((int)prev_hp.integer_part(), 1);
			u->order_type = get_order_type(Orders::Die);
			u->order_state = 1;
			//destroy_sprite(u->sprite);
			u->sprite = nullptr;
			free_path(u);
			int prev_max_hp = prev_unit_type->hitpoints.integer_part();
			int hp = prev_max_hp ? prev_hp.integer_part() * u->unit_type->hitpoints.integer_part() / prev_max_hp : 1;
			if (hp == 0) u->hp = 1_fp8;
			else u->hp = fp8::integer(hp);
			u->sprite->owner = prev_sprite_owner;
			u_unset_status_flag(u, unit_t::status_flag_disabled);
			u_unset_status_flag(u, unit_t::status_flag_iscript_nobrk);
			u_set_status_flag(u, unit_t::status_flag_order_not_interruptible, !prev_order_type->can_be_interrupted);
			u->order_type = prev_order_type;
			u->order_target = prev_order_target;
			u->order_state = prev_order_state;
			if (u_grounded_building(u) && !u->build_queue.empty()) u->build_queue.erase(u->build_queue.begin());
			if (ut_resource(u)) set_unit_resources(u, prev_resources);
			if (was_hatchery && unit_is_hatchery(u)) u->building.hatchery.larva_spawn_side_values = prev_larva_spawn_side_values;
		}

		void hide_image(image_t* image) {
			if (image->flags & image_t::flag_hidden) return;
			image->flags |= image_t::flag_hidden;
		}

		void set_sprite_cloak_modifier(sprite_t* sprite, bool requires_detector, bool cloaked, bool burrowed, int data1, int data2) {
			for (image_t* image : ptr(sprite->images)) {
				if (image->image_type->always_visible) continue;
				hide_image(image);
			}
			if (burrowed) {
				for (image_t* image : ptr(sprite->images)) {
					if (image->modifier >= 2 && image->modifier <= 7) set_image_modifier(image, 0);
				}
			}
			else if (requires_detector && !cloaked) {
				for (image_t* image : ptr(sprite->images)) {
					if (image->modifier == 0) {
						image->modifier = 2;
						image->modifier_data1 = data1;
						image->modifier_data2 = data2;
					}
				}
			}
			else if (!requires_detector && cloaked) {
				for (image_t* image : ptr(sprite->images)) {
					if (image->modifier == 0) {
						image->modifier = 4;
						image->modifier_data1 = data1;
						image->modifier_data2 = data2;
					}
				}
			}
			else {
				for (image_t* image : ptr(sprite->images)) {
					if (image->modifier == 0 || image->modifier == 2 || image->modifier == 4) {
						image->modifier = 3;
					}
				}
			}
		}

		void move_unit(unit_t* u, xy pos) {
			u->position = pos;
			u->exact_position = to_xy_fp8(pos);
			move_sprite(u->sprite, pos);
			if (u->order_type->id != Orders::Die) {
				set_unit_move_target(u, pos);
				set_next_target_waypoint(u, pos);
			}
			if (!ut_turret(u)) {
				//unit_finder_reinsert(u);
				if (!us_hidden(u)) check_unit_collision(u);
			}
		}

		void tiles_flags_or(size_t offset_x, size_t offset_y, size_t width, size_t height, int flags) {
			// TODO
		}

		void set_unit_tiles_occupied(unit_type_autocast ut, xy position) {
			xy size(ut->placement_size.x / 32u, ut->placement_size.y / 32u);
			xy pos(position.x / 32u, position.y / 32u);
			tiles_flags_or(pos.x - size.x / 2, pos.y - size.y / 2, size.x, size.y, tile_t::flag_occupied);
		}


		bool unit_tech_target_valid(const unit_t* u, const tech_type_t* tech, const unit_t* target) const {
			if (target->stasis_timer) return false;
			switch (tech->id) {
			case TechTypes::Feedback:
				if (ut_building(target)) return false;
				if (!ut_has_energy(target)) return false;
				if (u_hallucination(target)) return false;
				return true;
			case TechTypes::Mind_Control:
				if (target->owner == u->owner) return false;
				if (ut_building(target)) return false;
				if (unit_is(target, UnitTypes::Terran_Vulture_Spider_Mine)) return false;
				if (unit_is(target, UnitTypes::Zerg_Larva)) return false;
				if (unit_is_egg(target)) return false;
				if (unit_is(target, UnitTypes::Protoss_Interceptor)) return false;
				if (unit_is(target, UnitTypes::Protoss_Scarab)) return false;
				return true;
			case TechTypes::Hallucination:
				if (ut_building(target)) return false;
				if (unit_is(target, UnitTypes::Protoss_Interceptor)) return false;
				return true;
			case TechTypes::Defensive_Matrix:
			case TechTypes::Irradiate:
			case TechTypes::Restoration:
			case TechTypes::Optical_Flare:
				if (ut_building(target)) return false;
				return true;
			case TechTypes::Consume:
				if (ut_building(target)) return false;
				if (target->owner != u->owner) return false;
				if (unit_race(target) == race_t::terran) return false;
				if (unit_is(target, UnitTypes::Zerg_Larva)) return false;
				return true;
			default:
				return false;
			}
		}

		const tech_type_t* get_tech_type(TechTypes id) const {
			return &game_st.tech_types.vec[(size_t)id];
		}
		void create_defensive_matrix_image(unit_t* u) {
			if (u->defensive_matrix_timer && !u_burrowed(u)) {
				create_sized_image(u, ImageTypes::IMAGEID_Defensive_Matrix_Front_Small);
				//create_sized_image(u, ImageTypes::IMAGEID_Defensive_Matrix_Back_Small, true, image_order_below);
			}
		}

		void return_interceptors(unit_t* u) {
			if (!unit_is_carrier(u)) return;
			for (unit_t* n : ptr(u->carrier.outside_units)) {
				set_unit_order(n, get_order_type(Orders::InterceptorReturn));
			}
		}

		void set_unit_disabled(unit_t* u) {
			if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_disabled);
			stop_unit(u);
			if (unit_is_ghost(u) && u->connected_unit && unit_is(u->connected_unit, UnitTypes::Terran_Nuclear_Missile)) {
				u->connected_unit->connected_unit = nullptr;
				u->connected_unit = nullptr;
			}
			if (unit_is_carrier(u)) return_interceptors(u);
			if (u->order_type->id == Orders::Repair || u->order_type->id == Orders::DroneLand) u->order_state = 0;
			if (!u->order_type->unk9) u->order_target.unit = nullptr;
			iscript_run_to_idle(u);
		}

		void lockdown_unit(unit_t* u) {
			if (u->lockdown_timer == 0) {
				create_sized_image(u, ImageTypes::IMAGEID_Lockdown_Field_Small);
			}
			if (u->lockdown_timer < 131) u->lockdown_timer = 131;
			set_unit_disabled(u);
		}

		void maelstrom_unit(unit_t* u) {
			if (u->maelstrom_timer == 0) {
				create_sized_image(u, ImageTypes::IMAGEID_Maelstorm_Overlay_Small);
			}
			if (u->maelstrom_timer < 22) u->maelstrom_timer = 22;
			set_unit_disabled(u);
		}


		bool ut_mechanical(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_mechanical);
		}
		bool ut_robotic(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_robotic);
		}
		void irradiate_unit(unit_t* u, unit_t* source_unit, int source_owner) {
			if (u->irradiate_timer == 0 && !u_burrowed(u)) {
				create_sized_image(u, ImageTypes::IMAGEID_Irradiate_Small);
			}
			u->irradiate_timer = get_weapon_type(WeaponTypes::Irradiate)->cooldown;
			u->irradiated_by = source_unit;
			u->irradiate_owner = source_owner;
		}

		bool weapon_can_target_unit(const weapon_type_t* weapon, const unit_t* target) const {
			if (!target) return (weapon->target_flags & 0x40) != 0;
			if (u_invincible(target)) return false;
			if (~weapon->target_flags & (u_flying(target) ? 1 : 2)) return false;
			if (weapon->target_flags & 4 && !ut_mechanical(target)) return false;
			if (weapon->target_flags & 8 && !ut_organic(target)) return false;
			if (weapon->target_flags & 0x10 && ut_building(target)) return false;
			if (weapon->target_flags & 0x20 && ut_robotic(target)) return false;
			if (weapon->target_flags & 0x80 && !ut_mechanical(target) && !ut_organic(target)) return false;
			return true;
		}
		void ensnare_unit(unit_t* u) {
			if (!u->ensnare_timer && !u_burrowed(u)) {
				create_sized_image(u, ImageTypes::IMAGEID_Ensnare_Overlay_Small);
			}
			u->ensnare_timer = 75;
			update_unit_speed(u);
		}

		void stasis_unit(unit_t* u) {
			if (u->stasis_timer == 0) {
				create_sized_image(u, ImageTypes::IMAGEID_Stasis_Field_Small);
				u_set_status_flag(u, unit_t::status_flag_invincible);
			}
			if (u->stasis_timer < 131) u->stasis_timer = 131;
			set_unit_disabled(u);
		}

		void plague_unit(unit_t* u) {
			if (!u->plague_timer && !u_burrowed(u)) {
				create_sized_image(u, ImageTypes::IMAGEID_Plague_Overlay_Small);
			}
			u->plague_timer = 75;
		}

		void apply_unit_effects(unit_t* u) {
			if (u->defensive_matrix_timer) {
				if (u_invincible(u) || !unit_tech_target_valid(u, get_tech_type(TechTypes::Defensive_Matrix), u)) {
					u->defensive_matrix_hp = 0_fp8;
					u->defensive_matrix_timer = 0;
				}
				else {
					create_defensive_matrix_image(u);
				}
			}

			if (u->lockdown_timer) {
				auto timer = u->lockdown_timer;
				u->lockdown_timer = 0;
				lockdown_unit(u);
				u->lockdown_timer = timer;
			}
			if (u->maelstrom_timer) {
				auto timer = u->maelstrom_timer;
				u->maelstrom_timer = 0;
				maelstrom_unit(u);
				u->maelstrom_timer = timer;
			}
			if (u->irradiate_timer) {
				if (!weapon_can_target_unit(get_weapon_type(WeaponTypes::Irradiate), u)) {
					u->irradiate_timer = 0;
					u->irradiated_by = nullptr;
				}
				else {
					int timer = u->irradiate_timer;
					u->irradiate_timer = 0;
					irradiate_unit(u, u->irradiated_by, u->irradiate_owner);
					u->irradiate_timer = timer;
				}
			}
			if (u->ensnare_timer) {
				auto timer = u->ensnare_timer;
				u->ensnare_timer = 0;
				ensnare_unit(u);
				u->ensnare_timer = timer;
			}
			if (u->stasis_timer) {
				auto timer = u->stasis_timer;
				u->stasis_timer = 0;
				stasis_unit(u);
				u->stasis_timer = timer;
			}
			if (u->plague_timer) {
				auto timer = u->plague_timer;
				u->plague_timer = 0;
				plague_unit(u);
				u->plague_timer = timer;
			}
			if (u->acid_spore_count) {
				// TODO
				//create_image(get_image_type(acid_spore_image(u)), (u->subunit ? u->subunit : u)->sprite, {}, image_order_top);
			}
		}

		void morph_unit(unit_t* u, const unit_type_t* unit_type) {
			int visibility = u->sprite->visibility_flags;
			if (!us_hidden(u)) {
				//unit_finder_remove(u);
				if (u_grounded_building(u)) set_unit_tiles_unoccupied(u, u->sprite->position);
				if (u_flying(u)) decrement_repulse_field(u);
			}
			bool requires_detector = u_requires_detector(u);
			bool cloaked = u_cloaked(u);
			int data1;
			int data2;
			if (requires_detector || cloaked) {
				data1 = u->sprite->main_image->modifier_data1;
				data2 = u->sprite->main_image->modifier_data2;
			}
			reinitialize_unit_type(u, unit_type);
			if (requires_detector || cloaked) {
				set_sprite_cloak_modifier(u->sprite, requires_detector, cloaked, u_burrowed(u), data1, data2);
			}
			set_sprite_visibility(u->sprite, visibility);
			if (ut_building(u) && (requires_detector || cloaked)) {
				set_secondary_order(u, get_order_type(Orders::Nothing));
				u_unset_status_flag(u, unit_t::status_flag_requires_detector);
				u_unset_status_flag(u, unit_t::status_flag_cloaked);
			}
			xy new_pos = u->sprite->position;
			if (new_pos != u->sprite->position) move_unit(u, new_pos);
			if (!us_hidden(u)) {
				//unit_finder_insert(u);
				if (u_grounded_building(u)) set_unit_tiles_occupied(u, u->sprite->position);
				check_unit_collision(u);
				if (u_flying(u)) increment_repulse_field(u);
			}
			if (u->subunit) {
				requires_detector = u_requires_detector(u->subunit);
				cloaked = u_cloaked(u->subunit);
				int data1{};
				int data2{};
				if (requires_detector || cloaked) {
					data1 = u->subunit->sprite->main_image->modifier_data1;
					data2 = u->subunit->sprite->main_image->modifier_data2;
				}
				auto ius = make_thingy_setter(iscript_unit, u->subunit);
				reinitialize_unit_type(u->subunit, unit_type->turret_unit_type);
				u->subunit->sprite->flags |= sprite_t::flag_turret;
				if (requires_detector || cloaked) {
					set_sprite_cloak_modifier(u->subunit->sprite, requires_detector, cloaked, u_burrowed(u), data1, data2);
				}
				//set_image_offset(u->subunit->sprite->main_image, get_image_lo_offset(u->sprite->main_image, 2, 0));
				set_sprite_visibility(u->subunit->sprite, u->sprite->visibility_flags);
			}
			apply_unit_effects(u);
		}

		unit_t* build_refinery(const unit_t* u, const unit_type_t* unit_type) {
			unit_t* target = u->order_target.unit;
			if (!target || !unit_is(target, UnitTypes::Resource_Vespene_Geyser)) {
				target = get_building_at_center_position(u->order_target.pos, get_unit_type(UnitTypes::Resource_Vespene_Geyser));
				if (!target) return nullptr;
			}
			u_unset_status_flag(target, unit_t::status_flag_completed);
			set_unit_owner(target, u->owner, false);
			set_sprite_owner(target, u->owner);
			morph_unit(target, unit_type);
			// TODO
			//create_image(get_image_type(ImageTypes::IMAGEID_Vespene_Geyser2), target->sprite, {}, image_order_below);
			target->hp = unit_type->hitpoints / 10;
			return target;
		}

		void replace_sprite_images(sprite_t* sprite, const image_type_t* new_image_type, direction_t heading) {
			for (auto i = sprite->images.begin(); i != sprite->images.end();) {
				image_t* image = &*i++;
				destroy_image(image);
			}

			// TODO
			//create_image(new_image_type, sprite, {}, image_order_above);
			// TODO: Image heading/direction
		}

		void set_construction_graphic(unit_t* u, bool animated) {

			bool requires_detector_or_cloaked = u_requires_detector(u) || u_cloaked(u);
			int modifier_data1 = 0;
			int modifier_data2 = 0;
			if (requires_detector_or_cloaked) {
				modifier_data1 = u->sprite->main_image->modifier_data1;
				modifier_data2 = u->sprite->main_image->modifier_data2;
			}
			auto ius = make_thingy_setter(iscript_unit, u);
			const image_type_t* construction_image = u->unit_type->construction_animation;
			if (!animated || !construction_image || (int)construction_image->id == 0) construction_image = u->sprite->sprite_type->image;
			replace_sprite_images(u->sprite, construction_image, u->heading);

			if (requires_detector_or_cloaked) {
				set_sprite_cloak_modifier(u->sprite, u_requires_detector(u), u_cloaked(u), u_burrowed(u), modifier_data1, modifier_data2);
			}

			apply_unit_effects(u);
		}

		bool visible_to_everyone(const unit_t* u) const {
			if (ut_worker(u)) {
				if (u->worker.powerup && unit_is(u->worker.powerup, UnitTypes::Powerup_Flag)) return true;
				else return false;
			}
			if (!unit_provides_space(u)) return false;
			for (const unit_t* lu : loaded_units(u)) {
				if (lu->worker.powerup && unit_is(lu->worker.powerup, UnitTypes::Powerup_Flag)) return true;
			}
			return false;
		}

		int unit_sight_range(const unit_t* u, bool ignore_blindness = false) const {
			if (u_grounded_building(u) && !u_completed(u) && !unit_is_morphing_building(u)) return 32 * 4;
			if (!ignore_blindness && u->blinded_by) return 32 * 2;
			if (unit_is(u, UnitTypes::Terran_Ghost) && player_has_upgrade(u->owner, UpgradeTypes::Ocular_Implants)) return 32 * 11;
			if (unit_is(u, UnitTypes::Zerg_Overlord) && player_has_upgrade(u->owner, UpgradeTypes::Antennae)) return 32 * 11;
			if (unit_is(u, UnitTypes::Protoss_Observer) && player_has_upgrade(u->owner, UpgradeTypes::Sensor_Array)) return 32 * 11;
			if (unit_is(u, UnitTypes::Protoss_Scout) && player_has_upgrade(u->owner, UpgradeTypes::Apial_Sensors)) return 32 * 11;
			return 32 * u->unit_type->sight_range;
		}
		bool initialize_unit(unit_t* u, const unit_type_t* unit_type, xy pos, int owner) {

			u->order_queue.clear();

			u->auto_target_unit = nullptr;
			u->connected_unit = nullptr;

			u->order_queue_count = 0;
			u->order_process_timer = 0;
			u->previous_unit_type = nullptr;

			u->remove_timer = 0;
			u->defensive_matrix_hp = 0_fp8;
			u->defensive_matrix_timer = 0;
			u->stim_timer = 0;
			u->ensnare_timer = 0;
			u->lockdown_timer = 0;
			u->irradiate_timer = 0;
			u->stasis_timer = 0;
			u->plague_timer = 0;
			u->storm_timer = 0;
			u->irradiated_by = nullptr;
			u->irradiate_owner = 0;
			u->parasite_flags = 0;
			u->cycle_counter = 0;
			u->blinded_by = 0;
			u->maelstrom_timer = 0;
			u->acid_spore_count = 0;
			u->acid_spore_time = {};
			u->status_flags = 0;
			u->pathing_flags = 0;
			u->previous_hp = 1;

			if (!initialize_unit_type(u, unit_type, pos, owner)) return false;

			u->build_queue.clear();
			++u->unit_id_generation;
			//u->wireframe_randomizer = lcg_rand(15) & 0xff;
			if (ut_turret(u)) u->hp = 1_fp8;
			else u->hp = u->unit_type->hitpoints / 10;
			if (u_grounded_building(u)) u->order_type = u->unit_type->human_ai_idle;
			else u->order_type = get_order_type(Orders::Nothing);
			set_secondary_order(u, get_order_type(Orders::Nothing));
			u->unit_finder_bounding_box = { {-1, -1}, {-1, -1} };
			st.player_units[owner].push_front(*u);

			if (u_grounded_building(u)) {
				//unit_finder_insert(u);
				set_unit_tiles_occupied(u, u->sprite->position);
				check_unit_collision(u);
				if (u_flying(u)) increment_repulse_field(u);
				set_construction_graphic(u, true);
				set_sprite_visibility(u->sprite, 0);
			}
			else {
				u->sprite->flags |= sprite_t::flag_hidden;
				set_sprite_visibility(u->sprite, 0);
			}
			u->detected_flags = 0xffffffff;
			if (ut_turret(u)) {
				u->sprite->flags |= sprite_t::flag_turret;
			}
			
			if (unit_is_vulture(u)) {
				u->vulture.spider_mine_count = 3;
			}

			return true;
		}
		void destroy_unit(unit_t* u) {
			// TODO: Handled in factorio
		}
		unit_t* create_unit(const unit_type_t* unit_type, xy pos, int owner) {
			lcg_rand(14);
			auto get_new = [&](const unit_type_t* unit_type) {
				unit_t* u = st.units_container.top();
				if (!u) {
					return (unit_t*)nullptr;
				}
				if (!initialize_unit(u, unit_type, pos, owner)) {
					return (unit_t*)nullptr;
				}
				st.units_container.pop();
				return u;
			};
			unit_t* u = get_new(unit_type);
			if (!u) return nullptr;
			if (u_grounded_building(u)) bw_insert_list(st.visible_units, *u);
			else bw_insert_list(st.hidden_units, *u);

			if (unit_type->id < UnitTypes::Terran_Command_Center && unit_type->turret_unit_type) {
				unit_t* su = get_new(unit_type->turret_unit_type);
				if (!su) {
					destroy_unit(u);
					return nullptr;
				}
				u->subunit = su;
				su->subunit = u;
				//set_image_offset(su->sprite->main_image, get_image_lo_offset(u->sprite->main_image, 2, 0));
			}
			else {
				u->subunit = nullptr;
			}
			return u;
		}

		void order_PlaceBuilding(unit_t* u) {
			if (u->order_state == 0) {
				if (u->order_target.unit) {
					u->order_target.pos = u->order_target.unit->sprite->position;
				}
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					const unit_type_t* unit_type = u->build_queue.front();
					auto can_build = [&]() {
						if (u_immovable(u)) return false;
						if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() > 128) return false;
						if (!player_has_supply_and_resources_for(u->owner, unit_type)) return false;
						if (!can_place_building(u, u->owner, unit_type, u->order_target.pos, true, false)) return false;
						return true;
					};
					if (can_build()) {
						u_unset_status_flag(u, unit_t::status_flag_ground_unit);
						u->sprite->elevation_level = u->unit_type->elevation_level + 1;
						if (u->order_queue.empty()) {
							queue_order_back(u, get_order_type(Orders::ResetCollision), {});
							queue_order_back(u, u->unit_type->return_to_idle, {});
						}
						else {
							queue_order_front(u, get_order_type(Orders::ResetCollision), {});
						}
						unit_t* build_unit;
						if (unit_type->id == UnitTypes::Terran_Refinery) build_unit = build_refinery(u, unit_type);
						else build_unit = create_unit(unit_type, u->order_target.pos, u->owner);
						u->build_queue.erase(u->build_queue.begin());
						if (build_unit) {
							build_unit->connected_unit = u;
							u->order_type = get_order_type(Orders::ConstructingBuilding);
							u->order_state = 3;
							u->order_target.unit = build_unit;
							set_unit_order(build_unit, get_order_type(Orders::IncompleteBuilding));
						}
						else {
							set_unit_order(u, u->unit_type->return_to_idle, {});
						}
					}
					else {
						order_done(u);
					}
				}
			}
		}

		void order_IncompleteBuilding(unit_t* u) {
			if (u->order_state == 0) {
				if (u->hp > u->unit_type->hitpoints / 5) ++u->order_state;
			}
			else if (u->order_state == 1) {
				sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
				++u->order_state;
			}
			else if (u->order_state == 2) {
				if (u->hp > u->unit_type->hitpoints * 2 / 5) ++u->order_state;
			}
			else if (u->order_state == 3) {
				sprite_run_anim(u->sprite, iscript_anims::SpecialState2);
				++u->order_state;
			}
			else if (u->order_state == 4) {
				if (u->hp > u->unit_type->hitpoints * 3 / 5) ++u->order_state;
			}
			else if (u->order_state == 5) {
				set_construction_graphic(u, false);
				sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
				++u->order_state;
			}
			else if (u->order_state == 6) {
				if (u->hp > u->unit_type->hitpoints * 4 / 5) set_unit_order(u, get_order_type(Orders::Nothing));
			}
		}

		bool unit_can_gather_gas(const unit_t* u, const unit_t* target) const {
			if (!ut_worker(u)) return false;
			if (!unit_is_refinery(target)) return false;
			if (!u_completed(target)) return false;
			if (target->owner != u->owner) return false;
			return true;
		}

		bool is_at_next_target_waypoint_or_within_attack_angle(const unit_t* u) const {
			if (u->position == u->next_target_waypoint) return true;
			auto* weapon = unit_ground_weapon(u);
			if (weapon) {
				auto heading_error = fp8::extend(u->heading - xy_direction(u->next_target_waypoint - u->sprite->position)).abs();
				if (heading_error <= weapon->attack_angle) return true;
			}
			return false;
		}

		void set_unit_heading(unit_t* u, direction_t heading) {
			u->next_velocity_direction = heading;
			u->heading = heading;
			u->current_velocity_direction = heading;
			u->velocity = direction_xy(heading, u->current_speed);
			set_next_target_waypoint(u, u->sprite->position);
			// TODO: Image heading/direction
		}

		bool unit_is_trap_or_door(unit_type_autocast ut) const {
			return ut->id >= UnitTypes::Special_Floor_Missile_Trap && ut->id <= UnitTypes::Special_Right_Wall_Flame_Trap;
		}

		bool update_thingy_visibility(thingy_t* t, xy size) {
			if (!t->sprite || s_flag(t->sprite, sprite_t::flag_hidden)) return false;
			return true;
		}

		void update_unit_sprite(unit_t* u) {
			if (update_thingy_visibility(u, u->unit_type->placement_size)) {
				if (u->subunit && !us_hidden(u->subunit)) {
					set_sprite_visibility(u->subunit->sprite, u->sprite->visibility_flags);
				}
			}
		}

		void show_unit(unit_t* u) {
			if (!us_hidden(u)) return;
			u->sprite->flags &= ~sprite_t::flag_hidden;
			unit_t* turret = unit_turret(u);
			if (turret) turret->sprite->flags &= ~sprite_t::flag_hidden;
			update_unit_sprite(u);
			//unit_finder_insert(u);
			if (u_grounded_building(u)) set_unit_tiles_occupied(u, u->sprite->position);
			check_unit_collision(u);
			if (u_flying(u)) increment_repulse_field(u);
			reset_movement_state(u);
			if (turret) reset_movement_state(turret);
			st.hidden_units.remove(*u);
			bw_insert_list(st.visible_units, *u);
		}

		void finish_building_unit(unit_t* u) {
			if (u->remaining_build_time) {
				u->hp = u->unit_type->hitpoints;
				//u->shield_points = fp8::integer(u->unit_type->shield_points);
				u->remaining_build_time = 0;
			}
			if (u_grounded_building(u)) {
				u->parasite_flags = 0;
				u->blinded_by = 0;
				set_construction_graphic(u, false);
				sprite_run_anim(u->sprite, iscript_anims::Built);
			}
			else {
				if (u_can_turn(u)) {
					int dir = u->unit_type->unit_direction;
					if (dir == 32) dir = lcg_rand(36) % 32;
					set_unit_heading(u, 8_dir * dir);
				}
				if (unit_is_trap_or_door(u)) {
					show_unit(u);
				}
			}

		}

		bool ut_powerup(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_powerup);
		}

		bool is_in_bounds(rect area, rect bounds) const {
			if (area.from.x < bounds.from.x) return false;
			if (area.to.x > bounds.to.x) return false;
			if (area.from.y < bounds.from.y) return false;
			if (area.to.y > bounds.to.y) return false;
			return true;
		}

		bool is_in_inner_bounds(rect area, rect bounds) const {
			if (area.from.x < bounds.from.x) return false;
			if (area.to.x >= bounds.to.x) return false;
			if (area.from.y < bounds.from.y) return false;
			if (area.to.y >= bounds.to.y) return false;
			return true;
		}

		std::pair<bool, xy> find_unit_placement(const unit_t* u, xy pos, rect bounds, bool terrain_displaces_unit) const {
			// TODO: Factorio surface.find_non_colliding_position_in_box
			return { false, {} };
		}

		std::pair<bool, xy> find_unit_placement(const unit_t* u, xy pos, bool terrain_displaces_unit) const {
			return find_unit_placement(u, pos, { pos - xy(128, 128), pos + xy(127, 127) }, terrain_displaces_unit);
		}

		bool place_completed_unit(unit_t* u) {
			if (!us_hidden(u)) return true;
			bool res;
			xy pos;
			std::tie(res, pos) = find_unit_placement(u, u->sprite->position, false);
			if (!res) {
				return false;
			}
			move_unit(u, pos);
			unit_t* turret = unit_turret(u);
			if (turret) {
				u_set_status_flag(turret, unit_t::status_flag_completed);
				turret->hp = turret->unit_type->hitpoints;
				move_unit(turret, pos);
			}
			return true;
		}

		bool ut_initially_cloaked(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_initially_cloaked);
		}

		void set_unit_cloaked(unit_t* u) {
			// TODO
		}

		bool ut_detector(unit_type_autocast ut) const {
			return ut_flag(ut, unit_type_t::flag_detector);
		}
		bool unit_can_detect(const unit_t* u) const {
			if (!ut_detector(u)) return false;
			if (!u_completed(u)) return false;
			if (unit_is_disabled(u)) return false;
			if (u->blinded_by) return false;
			return true;
		}

		uint32_t unit_calculate_detected_flags(const unit_t* u) const {
			if (u->defensive_matrix_hp != 0_fp8 || u->lockdown_timer || u->maelstrom_timer || u->irradiate_timer || u->ensnare_timer || u->stasis_timer || u->plague_timer || u->acid_spore_count) {
				return 0xff;
			}
			else if (visible_to_everyone(u)) {
				return 0xff;
			}

			uint32_t detected_flags = 0;

			detected_flags |= 1 << u->owner;
			//detected_flags |= st.shared_vision[u->owner];
			detected_flags |= u->parasite_flags;

			/*for (size_t i = 0; i != st.shared_vision.size(); ++i) {
				if (u->parasite_flags & (1 << i)) detected_flags |= st.shared_vision[i];
			}*/

			auto test = [&](const unit_t* detector) {
				if (!unit_can_detect(detector)) return;
				if (detector == u) return;
				if (u_hallucination(detector)) return;
				if (~u->sprite->visibility_flags & (1 << detector->owner)) return;
				int range = u_grounded_building(detector) ? 32 * 7 : unit_sight_range(detector);
				if (!unit_target_in_range(detector, u, range)) return;
				detected_flags |= (1 << detector->owner) | detector->parasite_flags;
			};
			for (const unit_t* nu : find_units_noexpand(square_at(u->sprite->position, 32 * 11))) {
				test(nu);
			}

			return detected_flags;
		}

		void update_unit_detected_flags(unit_t* u) {
			uint32_t new_flags = unit_calculate_detected_flags(u);
			if (u->detected_flags == new_flags) return;
			uint32_t old_flags = u->detected_flags;
			if (old_flags == 0x80000000) {
				old_flags = ~new_flags & 0xff;
			}
			uint32_t removed_flags = old_flags & ~new_flags;
			u->detected_flags = new_flags;
			for (size_t i = 0; removed_flags; ++i) {
				if (removed_flags & (1 << i)) {
					removed_flags &= ~(1 << i);
					for (unit_t* nu : ptr(st.player_units.at(i))) {
						remove_target_references(nu, u);
					}
				}
			}
		}

		void cloak_unit(unit_t* u) {
			if (u_burrowed(u)) {
				if (!u_requires_detector(u)) {
					set_unit_cloaked(u);
					u_set_status_flag(u, unit_t::status_flag_requires_detector);
					u_set_status_flag(u, unit_t::status_flag_cloaked);
					set_sprite_cloak_modifier(u->sprite, true, true, true, 0, 0);
					set_secondary_order(u, get_order_type(Orders::Cloak));
					u->detected_flags = 0x80000000;
				}
				update_unit_detected_flags(u);
				u->secondary_order_timer = 30;
			}
			else {
				//play_sound(273, u);
				auto cloak = [&](unit_t* u) {
					u_unset_status_flag(u, unit_t::status_flag_cloaked);
					u_set_status_flag(u, unit_t::status_flag_requires_detector);
					for (image_t* image : ptr(u->sprite->images)) {
						if (image->modifier == 0 || image->modifier == 4 || image->modifier == 7) {
							image->modifier = 2;
							image->modifier_data1 = 0;
							image->modifier_data2 = 3;
						}
						if (!image->image_type->always_visible) hide_image(image);
					}
					u->detected_flags = 0x80000000;
				};
				cloak(u);
				if (u->subunit) cloak(u->subunit);
				update_unit_detected_flags(u);
				u->secondary_order_timer = 30;
			}
		}

		void complete_unit(unit_t* u) {
			if (ut_two_units_in_one_egg(u)) {
				u_set_status_flag(u, unit_t::status_flag_completed);
			}
			else {
				u_set_status_flag(u, unit_t::status_flag_completed);
			}

			if (ut_initially_cloaked(u)) cloak_unit(u);

			if (us_hidden(u)) {
				if (!unit_is(u, UnitTypes::Protoss_Interceptor) && !unit_is(u, UnitTypes::Protoss_Scarab)) {
					show_unit(u);
				}
			}

			if (unit_is_trap_or_door(u)) {
				u_set_status_flag(u, unit_t::status_flag_cloaked);
				u_set_status_flag(u, unit_t::status_flag_requires_detector);
				u->detected_flags = 0x80000000;
				u->secondary_order_timer = 0;
			}
			//set_unit_order(u, u->unit_type->computer_ai_idle);
			set_unit_order(u, u->unit_type->human_ai_idle);

			if (ut_powerup(u)) {
				u->building.powerup.origin = u->sprite->position;
				set_unit_order(u, u->unit_type->human_ai_idle);
			}
		}

		bool unit_can_attach_addon(const unit_t* u, const unit_t* addon) const {
			if (unit_is(addon, UnitTypes::Terran_Comsat_Station)) {
				if (unit_is(u, UnitTypes::Terran_Command_Center)) return true;
			}
			else if (unit_is(addon, UnitTypes::Terran_Nuclear_Silo)) {
				if (unit_is(u, UnitTypes::Terran_Command_Center)) return true;
			}
			else if (unit_is(addon, UnitTypes::Terran_Control_Tower)) {
				if (unit_is(u, UnitTypes::Terran_Starport)) return true;
			}
			else if (unit_is(addon, UnitTypes::Terran_Covert_Ops)) {
				if (unit_is(u, UnitTypes::Terran_Science_Facility)) return true;
			}
			else if (unit_is(addon, UnitTypes::Terran_Physics_Lab)) {
				if (unit_is(u, UnitTypes::Terran_Science_Facility)) return true;
			}
			else if (unit_is(addon, UnitTypes::Terran_Machine_Shop)) {
				if (unit_is(u, UnitTypes::Terran_Factory)) return true;
			}
			return false;
		}

		template<typename F>
		unit_t* find_unit_noexpand(rect area, F&& predicate) const {
			for (unit_t* u : find_units_noexpand(area)) {
				if (predicate(u)) return u;
			}
			return nullptr;
		}

		unit_t* find_connecting_addon(const unit_t* u) const {
			rect bb;
			bb.from = u->sprite->position - u->unit_type->placement_size / 2 - xy(32, 32);
			bb.to = bb.from + u->unit_type->placement_size + xy(64, 64);
			xy pos = u->sprite->position - u->unit_type->placement_size / 2;
			return find_unit_noexpand(bb, [&](unit_t* n) {
				if (!ut_addon(n)) return false;
				if (n->owner != 11) return false;
				if (!unit_can_attach_addon(u, n)) return false;
				xy npos = n->sprite->position - n->unit_type->placement_size / 2 - n->unit_type->addon_position;
				return pos / 32 == npos / 32;
				});
		}

		void connect_addon(unit_t* u, unit_t* addon) {
			u->building.addon = addon;
			set_unit_owner(addon, u->owner, false);
			set_sprite_owner(addon, u->owner);
			auto ius = make_thingy_setter(iscript_unit, addon);
			sprite_run_anim(addon->sprite, iscript_anims::Landing);
			if (unit_is(addon, UnitTypes::Terran_Nuclear_Silo)) {
				if (addon->building.silo.nuke) set_unit_owner(addon->building.silo.nuke, u->owner, false);
			}
		}

		void find_and_connect_addon(unit_t* u) {
			unit_t* addon = find_connecting_addon(u);
			if (addon) connect_addon(u, addon);
		}

		bool resume_building_unit(unit_t* u, bool place_when_completed) {
			set_unit_hp(u, u->hp + u->hp_construction_rate);
			if (u->remaining_build_time) {
				--u->remaining_build_time;
				return true;
			}
			finish_building_unit(u);
			if (place_when_completed) {
				if (!place_completed_unit(u)) return false;
			}
			complete_unit(u);
			if (u_grounded_building(u)) {
				if (unit_race(u) == race_t::terran) find_and_connect_addon(u);
			}
			else {
				// todo: callback for sound (morph)
			}
			return true;
		}

		void order_ConstructingBuilding(unit_t* u) {
			unit_t* target = u->order_target.unit;
			auto done = [&]() {
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
				if (target) {
					target->connected_unit = nullptr;
					// todo: callback for sound?
					if (unit_can_gather_gas(u, target)) {
						set_unit_order(u, get_order_type(Orders::Harvest1), target);
					}
					else {
						order_done(u);
					}
				}
				else order_done(u);
			};
			if (!target || !ut_building(target)) {
				done();
				return;
			}

			bool build = u->order_state >= 4;

			if (u->order_state == 0 || u->order_state == 2) {
				if (u->order_state == 0) {
					move_to_target_reset(u, target);
					u->order_state = 2;
				}
				if (unit_is_at_move_target(u)) {
					if (unit_is_at_move_target(u)) {
						if (u_immovable(u) || (target->connected_unit && target->connected_unit != u && target->connected_unit->order_target.unit == target)) {
							order_done(u);
						}
						else {
							target->connected_unit = u;
							u_unset_status_flag(u, unit_t::status_flag_ground_unit);
							u->sprite->elevation_level = u->unit_type->elevation_level + 1;
							set_queued_order(u, false, get_order_type(Orders::ResetCollision), {});
							set_queued_order(u, false, u->unit_type->return_to_idle, {});
							set_unit_move_target(u, target->sprite->position);
							set_next_target_waypoint(u, target->sprite->position);
							u->order_state = 3;
						}
					}
				}
			}
			else if (u->order_state == 3) {
				if (unit_is_at_move_target(u)) u->order_state = 4;
			}
			else if (u->order_state == 4) {
				rect sprite_rect;
				sprite_rect.from = target->sprite->position - xy(int(target->sprite->width / 2), int(target->sprite->height / 2));
				sprite_rect.to = sprite_rect.from + xy((int)target->sprite->width - 1, (int)target->sprite->height - 1);
				rect placement_rect;
				placement_rect.from = target->sprite->position - target->unit_type->placement_size / 2;
				placement_rect.to = placement_rect.from + target->unit_type->placement_size - xy(1, 1);
				rect inside_rect;
				inside_rect.from = placement_rect.from + u->unit_type->dimensions.from + xy(1, 1);
				inside_rect.to = placement_rect.to - u->unit_type->dimensions.to - xy(1, 1);
				if (inside_rect.from.x < sprite_rect.from.x) inside_rect.from.x = sprite_rect.from.x;
				if (inside_rect.from.y < sprite_rect.from.y) inside_rect.from.y = sprite_rect.from.y;
				if (inside_rect.to.x > sprite_rect.to.x) inside_rect.to.x = sprite_rect.to.x;
				if (inside_rect.to.y > sprite_rect.to.y) inside_rect.to.y = sprite_rect.to.y;
				xy pos;
				pos.x = lcg_rand(9, sprite_rect.from.x, sprite_rect.to.x);
				pos.y = lcg_rand(9, sprite_rect.from.y, sprite_rect.to.y);
				if (check_unit_movement_terrain_collision(u, pos - u->sprite->position)) {
					pos.x = lcg_rand(9, inside_rect.from.x, inside_rect.to.x);
					pos.y = lcg_rand(9, inside_rect.from.y, inside_rect.to.y);
				}
				set_unit_move_target(u, pos);
				set_next_target_waypoint(u, pos);
				u->order_target.pos = pos;
				u->order_state = 5;
			}
			else if (u->order_state == 5) {
				u->order_state = 6;
			}
			else if (u->order_state == 6) {
				if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= 20) {
					stop_unit(u);
					set_next_target_waypoint(u, target->sprite->position);
					u->order_target.pos = u->sprite->position + to_xy(direction_xy(xy_direction(u->next_target_waypoint - u->sprite->position), 20));
					u->order_state = 7;
				}
			}
			else if (u->order_state == 7) {
				if (is_at_next_target_waypoint_or_within_attack_angle(u)) {
					u->main_order_timer = 30 + (lcg_rand(10) & 63);
					sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
					u->order_state = 8;
				}
			}
			else if (u->order_state == 8) {
				if (u->main_order_timer == 0) {
					sprite_run_anim(u->sprite, iscript_anims::GndAttkToIdle);
					u->order_state = 4;
				}
			}

			if (build) {
				resume_building_unit(target, false);
				if (u_completed(target)) {
					done();
				}
			}

		}

		void order_ResetCollision(unit_t* u) {
			u->sprite->elevation_level = u->unit_type->elevation_level;
			u_unset_status_flag(u, unit_t::status_flag_gathering);
			u_unset_status_flag(u, unit_t::status_flag_no_collide);
			u_set_status_flag(u, unit_t::status_flag_ground_unit);
			check_unit_collision(u);
			reset_movement_state(u);
			if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		bool unit_can_enter_nydus(const unit_t* u, const unit_t* target) const {
			if (!unit_is_nydus(target)) return false;
			if (!u_completed(target)) return false;
			if (!target->building.nydus.exit || !u_completed(target->building.nydus.exit)) return false;
			if (u->owner != target->owner) return false;
			if (u_flying(u)) return false;
			if (unit_race(u) != race_t::zerg) return false;
			return true;
		}

		bool unit_can_use_shield_battery(const unit_t* u, const unit_t* target) const {
			if (!unit_is(target, UnitTypes::Protoss_Shield_Battery)) return false;
			if (!u_completed(target)) return false;
			if (!u->unit_type->has_shield) return false;
			if (!u_completed(u)) return false;
			if (!u_can_move(u)) return false;
			if (u_grounded_building(u)) return false;
			if (u->owner != target->owner) return false;
			if (unit_race(u) != race_t::protoss) return false;
			if (u->shield_points >= fp8::integer(u->unit_type->shield_points)) return false;
			if (target->energy == 0_fp8) return false;
			if (unit_is_disabled(target)) return false;
			if (unit_is(u, UnitTypes::Protoss_Interceptor) || unit_is(u, UnitTypes::Protoss_Scarab)) return false;
			return true;
		}

		// inconsistent pathing_flags check; fixme?
		bool is_reachable(const unit_t* from_u, const unit_t* to_u) const {
			return is_reachable(from_u->sprite->position, to_u->sprite->position);
		}

		bool try_follow_unit(unit_t* u, unit_t* target) {
			if (u->move_target_timer != 0) return true;
			if (!unit_target_is_visible(u, target)) {
				if (!unit_target_in_range(u, target, 32 * 14)) {
					if (unit_is_at_move_target(u) && !u_immovable(u)) {
						order_done(u);
						return false;
					}
					return true;
				}
			}
			move_to_target(u, target);
			return true;
		}

		void order_Follow(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				order_done(u);
				return;
			}
			if (u->order_state == 0) {
				move_to_target_reset(u, target);
				if (unit_is_nydus(target)) {
					if (unit_can_enter_nydus(u, target)) {
						set_unit_order(u, get_order_type(Orders::EnterNydusCanal), target);
						return;
					}
				}
				else if (unit_is(target, UnitTypes::Protoss_Shield_Battery)) {
					if (unit_can_use_shield_battery(u, target)) {
						set_unit_order(u, get_order_type(Orders::RechargeShieldsUnit), target);
						return;
					}
				}
				u->order_state = 1;
			}
			if (u->main_order_timer == 0) {
				u->main_order_timer = 7;
				if (unit_target_is_enemy(u, target) && unit_can_attack_target(u, target)) {
					set_unit_order(u, get_order_type(Orders::Guard));
					return;
				}
				if (!u_flying(u)) {
					if (!is_reachable(u, target)) {
						stop_unit(u);
						set_next_target_waypoint(u, u->move_target.pos);
						return;
					}
				}
				if (!unit_target_in_range(u, target, 32 * 3)) {
					try_follow_unit(u, target);
					return;
				}
				if (!u_grounded_building(target) && u->order_queue.empty()) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					return;
				}
				order_done(u);
			}
		}

		bool attack_move_movement(unit_t* u, bool stop_before_attacking = true) {
			if (u->order_state == 0) {
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
				u->order_state = 1;
			}
			unit_t* target = u->auto_target_unit;
			if (target && unit_target_is_enemy(u, target) && !us_hidden(target) && !u_invincible(target) && !unit_target_is_undetected(u, target)) {
				u->auto_target_unit = nullptr;
				if (stop_before_attacking) stop_unit(u);
				queue_order_front(u, u->order_type, { u->order_target.pos, u->order_target.unit });
				queue_order_front(u, u->unit_type->attack_unit, { target->sprite->position, target });
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
				u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
				if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
				return false;
			}
			return true;
		}

		void attack_move_acquire_target(unit_t* u, bool stop_before_attacking = true) {
			if (unit_target_acquisition_range(u) == 0) return;
			unit_t* target = find_acquire_target(u);
			if (target) {
				if (stop_before_attacking) stop_unit(u);
				queue_order_front(u, u->order_type, { u->order_target.pos, u->order_target.unit });
				queue_order_front(u, u->unit_type->attack_unit, { target->sprite->position, target });
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
				u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
				if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
			}
		}

		void order_AttackMove(unit_t* u) {
			if (attack_move_movement(u)) {
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					if (!unit_is_at_move_target(u)) {
						attack_move_acquire_target(u);
					}
					else {
						order_done(u);
					}
				}
			}
		}

		bool u_ready_to_attack(const unit_t* u) const {
			return u_status_flag(u, unit_t::status_flag_ready_to_attack);
		}
		void attack_unit_reacquire_target(unit_t* u) {
			if (!u_ready_to_attack(u)) return;
			unit_t* target = u->order_target.unit;
			int target_priority = std::numeric_limits<int>::max();
			if (target) {
				if (unit_can_attack_target(u, target)) {
					target_priority = unit_target_attack_priority(u, target);
					if (target_priority == 0) {
						if (unit_target_in_weapon_movement_range(u, target)) return;
						target_priority = 1;
					}
				}
				else target = nullptr;
			}
			unit_t* auto_target = u->auto_target_unit;
			if (auto_target) {
				if (unit_can_attack_target(u, auto_target) && unit_target_is_enemy(u, auto_target)) {
					int auto_target_priority = unit_target_attack_priority(u, auto_target);
					if (auto_target_priority == 0) {
						if (!unit_target_in_weapon_movement_range(u, auto_target)) auto_target_priority = 1;
					}
					if (auto_target_priority < target_priority) {
						target_priority = auto_target_priority;
						target = auto_target;
					}
				}
				else u->auto_target_unit = nullptr;
			}
			if (!target || target_priority != 0) {
				unit_t* new_target = find_acquire_target(u);
				if (new_target && unit_target_attack_priority(u, new_target) < target_priority) {
					target = new_target;
				}
			}
			if (!target || unit_can_attack_target(u, target)) {
				u->order_target.unit = target;
				if (u->subunit) {
					if (u->subunit->order_type == u->subunit->unit_type->attack_unit || u->subunit->order_type->id == Orders::HoldPosition) {
						u->subunit->order_target.unit = target;
					}
				}
			}
		}

		bool unit_target_out_of_max_range(const unit_t* u, const unit_t* target) const {
			if (!unit_can_see_target(u, target)) return true;
			auto* w = unit_target_weapon(u, target);
			if (!w) return false;
			int d = units_distance(u, target);
			int max_range = weapon_max_range(u, w);
			max_range += unit_target_movement_range(u, target);
			return d > max_range;
		}

		void follow_ahead_of_unit(unit_t* u, unit_t* target) {
			if (u->move_target_timer != 0) return;
			if (unit_can_see_target(u, target) & u_movement_flag(target, 2)) {
				xy move_target = target->sprite->position;
				fp8 halt_distance = unit_halt_distance(u);
				xy pos = target->sprite->position + to_xy(direction_xy(target->next_velocity_direction, halt_distance * 3));
				move_target = pos;
				set_unit_move_target(u, move_target);
			}
			else {
				try_follow_unit(u, target);
			}
		}

		bool attack_unit_move_in_range(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!unit_can_attack_target(u, target)) {
				if (!target || u_ready_to_attack(u)) {
					stop_unit(u);
					order_done(u);
				}
				else {
					queue_order_front(u, get_order_type(Orders::Move), target->sprite->position);
					order_done(u);
				}
				return false;
			}
			u->order_target.pos = target->sprite->position;
			set_next_target_waypoint(u, target->sprite->position);
			if (u->order_state == 0) {
				if (target && !unit_target_in_weapon_movement_range(u, target)) {
					move_to_target(u, target);
				}
				u->order_state = 1;
				return true;
			}
			else {
				if (unit_target_out_of_max_range(u, target)) {
					if ((unit_is_at_move_target(u) && u_immovable(u)) || (u_ready_to_attack(u) && !u_status_flag(u, unit_t::status_flag_8) && !u_flying(u) && u_flying(u->order_target.unit))) {
						stop_unit(u);
						set_next_target_waypoint(u, u->move_target.pos);
						order_done(u);
						return false;
					}
					if (unit_is(u, UnitTypes::Zerg_Scourge) || (u->unit_type->ground_weapon && u->unit_type->ground_weapon->flingy->id == (FlingyTypes)0)) {
						follow_ahead_of_unit(u, target);
					}
					else {
						try_follow_unit(u, target);
					}
					return false;
				}
				else {
					if (unit_is(u, UnitTypes::Zerg_Scourge)) {
						follow_ahead_of_unit(u, target);
					}
					else {
						stop_unit(u);
					}
					return true;
				}
			}
		}

		int unit_distance_to(const unit_t* u, xy pos) const {
			return xy_length(pos - nearest_pos_in_rect(pos, unit_sprite_bounding_box(u)));
		}

		bool unit_can_fire_weapon(unit_t* u, const weapon_type_t* weapon) {
			if (u_movement_flag(u, 8)) return false;
			unit_t* target = u->order_target.unit;
			int distance;
			if (target) {
				distance = units_distance(unit_main_unit(u), target);
			}
			else {
				distance = unit_distance_to(unit_main_unit(u), u->order_target.pos);
			}
			if (weapon->min_range && distance < weapon->min_range) return false;
			if (distance > weapon_max_range(u, weapon)) return false;
			if (u->pathing_flags & 2) return false;
			if (u->position != u->next_target_waypoint) {
				if (unit_is(u, UnitTypes::Zerg_Lurker)) {
					u->heading = xy_direction(u->next_target_waypoint - u->sprite->position);
				}
				else if (fp8::extend(xy_direction(u->next_target_waypoint - u->sprite->position) - u->heading).abs() > weapon->attack_angle) {
					u->order_process_timer = 0;
					return false;
				}
			}
			return true;
		}

		int get_modified_weapon_cooldown(const unit_t* u, const weapon_type_t* weapon) const {
			int cooldown = weapon->cooldown;
			if (u->acid_spore_count) {
				cooldown += std::max(cooldown / 8, 3) * u->acid_spore_count;
			}
			int mod = 0;
			if (u->stim_timer) ++mod;
			if (u_cooldown_upgrade(u)) ++mod;
			if (u->ensnare_timer) --mod;
			if (mod > 0) cooldown /= 2;
			if (mod < 0) cooldown += cooldown / 4;
			if (cooldown > 250) cooldown = 250;
			if (cooldown < 5) cooldown = 5;
			return cooldown;
		}

		void attack_unit_fire_weapon(unit_t* u) {
			st.prev_bullet_source_unit = nullptr;
			if (u_cannot_attack(u)) return;
			unit_t* target = u->order_target.unit;
			const weapon_type_t* weapon;
			int cooldown;
			int anim;
			if (target && u_flying(target)) {
				weapon = unit_air_weapon(u);
				cooldown = u->air_weapon_cooldown;
				anim = iscript_anims::AirAttkRpt;
			}
			else {
				weapon = unit_ground_weapon(u);
				cooldown = u->ground_weapon_cooldown;
				anim = iscript_anims::GndAttkRpt;
			}
			if (!weapon) return;
			if (cooldown != 0) {
				if (u->order_process_timer > cooldown - 1) u->order_process_timer = cooldown - 1;
				return;
			}
			if (!unit_can_fire_weapon(u, weapon)) return;
			u_set_movement_flag(u, 8);
			cooldown = get_modified_weapon_cooldown(u, weapon) + (lcg_rand(12) & 3) - 1;
			u->ground_weapon_cooldown = cooldown;
			u->air_weapon_cooldown = cooldown;
			sprite_run_anim(u->sprite, anim);
		}

		void order_AttackUnit(unit_t* u) {
			attack_unit_reacquire_target(u);
			if (attack_unit_move_in_range(u)) {
				attack_unit_fire_weapon(u);
			}
		}

		void order_MoveToGas(unit_t* u) {
			if (u->carrying_flags && (u->carrying_flags & 3) == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
			set_unit_gathering(u);
			unit_t* target = u->order_target.unit;
			if (u->order_state == 0) {
				if (!target) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					order_done(u);
				}
				else if (unit_is_mineral_field(target)) {
					queue_order_front(u, get_order_type(Orders::MoveToMinerals), { u->order_target.pos, target });
					order_done(u);
				}
				else {
					move_to_target_reset(u, target);
					u->worker.target_resource_position = u->order_target.pos;
					u->worker.target_resource_unit = target;
					u->order_state = 3;
				}
			}
			else if (u->order_state == 3) {
				if (unit_is_at_move_target(u)) {
					if (!target || !unit_can_gather_gas(u, target)) {
						stop_unit(u);
						set_next_target_waypoint(u, u->move_target.pos);
						order_done(u);
					}
					else {
						if (u_immovable(u)) u->order_state = 0;
						else if (u->carrying_flags & 1) set_unit_order(u, get_order_type(Orders::ReturnGas));
						else {
							queue_order_front(u, get_order_type(Orders::WaitForGas), { target->sprite->position, target });
							order_done(u);
						}
					}
				}
			}
		}

		void order_WaitForGas(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (target && unit_can_gather_gas(u, target) && (u->carrying_flags == 0 || u->carrying_flags & 3)) {
				if (u->order_state == 0) {
					wait_for_resource(u, target);
				}
			}
			else {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
		}

		bool find_gas_exit_position(const unit_t* u, const unit_t* gas, xy& pos, direction_t& heading) {
			const unit_t* resource_depot = find_nearest_active_resource_depot(u);
			if (!resource_depot || !gas) {
				auto r = find_unit_placement(u, u->sprite->position, true);
				pos = r.second;
				heading = u->heading;
				return r.first;
			}
			heading = xy_direction(resource_depot->sprite->position - gas->sprite->position);
			xy offset = to_xy(direction_xy(heading - 64_dir, 32));
			xy from_pos = gas->sprite->position + offset;
			xy to_pos = resource_depot->sprite->position + offset;

			auto bb = unit_sprite_inner_bounding_box(gas);
			bb.from -= u->unit_type->dimensions.to + xy(1, 1);
			bb.to += u->unit_type->dimensions.from + xy(1, 1);
			get_unique_sided_positions_within_bounds(from_pos, to_pos, bb);
			auto r = find_unit_placement(u, to_pos, bb, true);
			if (!r.first) r = find_unit_placement(u, to_pos, true);
			pos = r.second;
			return r.first;
		}

		void order_HarvestGas(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (us_hidden(u) || (target && unit_can_gather_gas(u, target) && (u->carrying_flags == 0 || u->carrying_flags & 3))) {
				set_unit_gathering(u);
				if (u->order_state == 0) {
					hide_unit(u);
					u->order_state = 5;
					u->main_order_timer = 37;
				}
				else if (u->order_state == 5) {
					if (u->main_order_timer == 0) {
						xy pos;
						direction_t heading = u->heading;
						if (find_gas_exit_position(u, target, pos, heading)) {
							set_unit_heading(u, heading);
							move_unit(u, pos);
							show_unit(u);
							if (target) unit_gather_resources_from(u, target);
							if (u->worker.gather_target) gather_queue_next(u, u->worker.gather_target);
							remove_one_order(u, get_order_type(Orders::ResetHarvestCollision));
							if (u->order_queue.empty()) {
								if (u->carrying_flags & 1) {
									set_queued_order(u, false, get_order_type(Orders::ReturnGas), {});
								}
								else {
									set_queued_order(u, false, u->unit_type->return_to_idle, {});
								}
							}
							queue_order_front(u, get_order_type(Orders::ResetHarvestCollision), {});
							u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
							order_done(u);
						}
						else {
							u->main_order_timer = 18;
						}
					}
				}
			}
			else {
				stop_unit(u);
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
				if (u->worker.gather_target) gather_queue_next(u, u->worker.gather_target);
			}
		}

		void order_Repair(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || target->hp >= target->unit_type->hitpoints || target->stasis_timer || u_loaded(target) || !ut_mechanical(target) || !u_completed(target)) {
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
				order_done(u);
				if (target && !u_loaded(target)) target->connected_unit = nullptr;
				return;
			}
			if (unit_race(target) != race_t::terran) {
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
				order_done(u);
				return;
			}

			int time_cost;
			auto calc_repair_costs = [&]() {
				int target_mineral_cost = target->unit_type->mineral_cost;
				int target_gas_cost = target->unit_type->gas_cost;
				int lowest_cost = target_gas_cost == 0 ? target_mineral_cost : std::min(target_mineral_cost, target_gas_cost);
				if (lowest_cost) {
					auto target_max_hp = target->unit_type->hitpoints;
					auto hp_construction_rate = target->hp_construction_rate;
					time_cost = target_max_hp.raw_value * 3 / (lowest_cost * hp_construction_rate.raw_value);
					if (!time_cost) {
						time_cost = 1;
					}
				}
				else {
					time_cost = 0xffff;
				}
			};
			auto repair = [&]() {
				if (u->worker.repair_timer == 0) {
					calc_repair_costs();
					u->worker.repair_timer = time_cost;
				}
				else --u->worker.repair_timer;
				
				set_unit_hp(target, target->hp + target->hp_construction_rate);
				if (target->hp >= target->unit_type->hitpoints) {
					sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
					order_done(u);
					if (target && !u_loaded(target)) target->connected_unit = nullptr;
				}
			};

			if (u->order_state == 0 || u->order_state == 1) {
				if (u->order_state == 0) {
					u->worker.repair_timer = 0;
					u->order_state = 1;
				}
				if (u_completed(target)) {
					move_to_target_reset(u, target);
					u->order_target.pos = target->sprite->position;
					u->order_state = 6;
				}
				else {
					set_unit_order(u, get_order_type(Orders::ConstructingBuilding), target);
				}
			}
			else if (u->order_state == 6) {
				if (!unit_is_at_move_target(u)) {
					try_follow_unit(u, target);
				}
				else {
					if (unit_target_in_range(u, target, 5)) {
						set_next_target_waypoint(u, target->sprite->position);
						u->order_target.pos = target->sprite->position;
						u->order_state = 7;
						repair();
					}
					else {
						u->order_state = 1;
					}
				}
			}
			else if (u->order_state == 7) {
				if (unit_target_in_range(u, target, 5)) {
					set_next_target_waypoint(u, target->sprite->position);
					u->order_target.pos = target->sprite->position;
					if (is_at_next_target_waypoint_or_within_attack_angle(u)) {
						sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
						u->order_state = 8;
					}
					repair();
				}
				else {
					u->order_state = 1;
				}
			}
			else if (u->order_state == 8) {
				set_next_target_waypoint(u, target->sprite->position);
				u->order_target.pos = target->sprite->position;
				if (!unit_target_in_range(u, target, 5) || target->order_type->id == Orders::LiftingOff) {
					sprite_run_anim(u->sprite, iscript_anims::GndAttkToIdle);
					u->order_state = 1;
				}
				repair();
			}
			else repair();
		}

		size_t unit_space_left(const unit_t* u) const {
			size_t r = u->unit_type->space_provided;
			for (const unit_t* nu : loaded_units(u)) {
				r -= nu->unit_type->space_required;
			}
			return r;
		}

		bool unit_can_load_target(const unit_t* u, const unit_t* target) const {
			if (!u_completed(u)) return false;
			if (unit_is_disabled(u)) return false;
			if (u_burrowed(target)) return false;
			if (u->owner != target->owner) return false;
			if (ut_building(u)) {
				if (unit_race(target) != race_t::terran) return false;
				if (target->unit_type->space_required > 1) return false;
			}
			return unit_space_left(u) >= target->unit_type->space_required;
		}

		void unit_load_target(unit_t* u, unit_t* target) {
			size_t index = (size_t)-1;
			for (size_t i = 0; i != u->unit_type->space_provided; ++i) {
				unit_t* n = get_unit(u->loaded_units.at(i));
				if (!n) {
					index = i;
					break;
				}
			}
			//play_sound(40 + (int)unit_race(u), u);
			u->loaded_units.at(index) = get_unit_id(target);
			target->connected_unit = u;
			u_set_status_flag(target, unit_t::status_flag_loaded);
			hide_unit(target);
			sprite_run_anim(target->sprite, iscript_anims::WalkingToIdle);
			if (u_grounded_building(u)) {
				u_unset_status_flag(target, unit_t::status_flag_can_move);
				u_set_status_flag(target, unit_t::status_flag_in_bunker);
				reset_movement_state(target);
				unit_t* turret = unit_turret(target);
				if (turret) {
					move_unit(turret, u->sprite->position);
					u_unset_status_flag(turret, unit_t::status_flag_can_move);
					u_set_status_flag(turret, unit_t::status_flag_in_bunker);
					reset_movement_state(turret);
				}
				else move_unit(target, u->sprite->position);
			}
		}

		void order_EnterTransport(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || u_hallucination(target) || !unit_provides_space(target) || !unit_can_load_target(target, u)) {
				order_done(u);
				return;
			}
			if (u->order_state == 0) {
				if (target->order_type->id != Orders::PickupTransport) {
					if (u_can_move(target)) {
						queue_order_front(target, get_order_type(Orders::PickupTransport), { u->sprite->position, u });
						activate_next_order(target);
					}
					u->order_state = 1;
				}
			}
			set_next_target_waypoint(u, target->sprite->position);
			try_follow_unit(u, target);
			if (unit_target_in_range(u, target, 1)) {
				unit_load_target(target, u);
			}
		}

		void unit_unload_impl(unit_t* u, bool container_destroyed) {
			if (!u_loaded(u)) return;
			unit_t* container = u->connected_unit;
			if (container) {
				auto uid = get_unit_id(u);
				size_t index = (size_t)-1;
				for (size_t i = 0; i != container->unit_type->space_provided; ++i) {
					if (container->loaded_units[i] == uid) {
						index = i;
						break;
					}
				}
				container->loaded_units.at(index) = unit_id();
				u->connected_unit = nullptr;
				u_unset_status_flag(u, unit_t::status_flag_loaded);

				if (container_destroyed) {
					move_unit(u, container->sprite->position);
				}
				else {
					show_unit(u);
					//play_sound(43 + (int)unit_race(container), container);
				}
			}
			u_unset_status_flag(u, unit_t::status_flag_in_bunker);
			u_set_status_flag(u, unit_t::status_flag_can_move, ut_can_move(u));
			reset_movement_state(u);
			unit_t* turret = unit_turret(u);
			if (turret) {
				u_unset_status_flag(turret, unit_t::status_flag_in_bunker);
				u_set_status_flag(turret, unit_t::status_flag_can_move, ut_can_move(turret));
				reset_movement_state(turret);
			}
		}

		bool unit_unload(unit_t* u) {
			unit_t* container = u->connected_unit;
			if (!container || unit_is_disabled(container)) return false;
			if (!u_grounded_building(container) && container->main_order_timer) return false;
			xy pos = container->sprite->position;
			bool r;
			move_unit(u, pos);
			std::tie(r, pos) = find_unit_placement(u, pos, false);
			if (!r) return false;
			container->main_order_timer = 15;
			move_unit(u, pos);
			if (u->subunit) move_unit(u->subunit, pos);
			iscript_run_to_idle(u);
			unit_unload_impl(u, false);
			set_unit_order(u, u->unit_type->return_to_idle);
			if (!u_grounded_building(container)) {
				if (unit_is(u, UnitTypes::Protoss_Reaver)) u->main_order_timer = 30;
				else {
					auto* ground_weapon = unit_ground_weapon(u);
					auto* air_weapon = unit_air_weapon(u);
					if (ground_weapon) u->ground_weapon_cooldown = get_modified_weapon_cooldown(u, ground_weapon);
					if (air_weapon) u->air_weapon_cooldown = get_modified_weapon_cooldown(u, air_weapon);
					u->spell_cooldown = 30;
				}
			}
			return true;
		}

		void order_Unload(unit_t* u) {
			if (u_grounded_building(u)) {
				for (unit_t* n : loaded_units(u)) {
					unit_unload(n);
				}
				order_done(u);
			}
			else {
				if (u->main_order_timer == 0) {
					if (loaded_units(u).empty()) {
						order_done(u);
					}
					else {
						auto lu = loaded_units(u);
						auto i = lu.begin();
						bool is_last = std::next(i) == lu.end();
						if (!unit_unload(*i) || is_last) {
							order_done(u);
						}
					}
				}
			}
		}

		bool unit_dying(const unit_t* u) const {
			if (!u->order_type) return true;
			return u->order_type->id == Orders::Die;
		}

		void partially_refund_unit_costs(int owner, unit_type_autocast unit_type) {
			// TODO
		}

		unit_t* create_unit(UnitTypes unit_type_id, xy pos, int owner) {
			return create_unit(get_unit_type(unit_type_id), pos, owner);
		}

		const sprite_type_t* get_sprite_type(SpriteTypes id) const {
			return &global_st.sprite_types.vec[(size_t)id];
		}

		thingy_t* new_thingy() {
			if (!st.free_thingies.empty()) {
				thingy_t* r = &st.free_thingies.front();
				st.free_thingies.pop_front();
				return r;
			}
			if (st.thingies.size() >= 500) return nullptr;
			return &*st.thingies.emplace(st.thingies.end());
		}

		bool initialize_sprite(sprite_t* sprite, const sprite_type_t* sprite_type, xy pos, int owner) {
			sprite->owner = owner;
			sprite->sprite_type = sprite_type;
			sprite->flags = 0;
			sprite->position = pos;
			sprite->visibility_flags = ~0;
			sprite->elevation_level = 4;
			sprite->images.clear();
			if (!sprite_type->visible) {
				sprite->flags |= sprite_t::flag_hidden;
				set_sprite_visibility(sprite, 0);
			}
			// TODO
			return true;
		}

		sprite_t* create_sprite(const sprite_type_t* sprite_type, xy pos, int owner) {
			sprite_t* sprite = st.sprites_container.top();
			if (!sprite) return nullptr;
			st.sprites_container.pop();

			if (!initialize_sprite(sprite, sprite_type, pos, owner)) {
				st.sprites_container.push(sprite);
				return nullptr;
			}
			return sprite;
		}

		bool initialize_thingy(thingy_t* t, const sprite_type_t* sprite_type, xy pos, int owner) {
			t->hp = 1_fp8;
			t->sprite = create_sprite(sprite_type, pos, owner);
			if (!t->sprite) return false;
			return true;
		}

		thingy_t* create_thingy(const sprite_type_t* sprite_type, xy pos, int owner) {
			thingy_t* t = new_thingy();
			if (!t) return nullptr;
			if (!initialize_thingy(t, sprite_type, pos, owner)) {
				st.free_thingies.push_front(*t);
				return nullptr;
			}
			++st.active_thingies_size;
			bw_insert_list(st.active_thingies, *t);
			return t;
		}

		uint8_t tile_visibility(xy pos) const {
			return ~st.tiles[tile_index(pos)].visible;
		}

		bool remove_creep_provider(unit_type_autocast unit_type, xy pos, bool is_completed) {
			// TODO: Factorio rewrite
			return true;
		}

		bool remove_creep_provider(const unit_t* u) {
			return remove_creep_provider(u, u->position, u_completed(u));
		}

		void cancel_morphing_building(unit_t* u) {
			if (unit_is_morphing_building(u)) {
				const unit_type_t* build_type = u->build_queue.front();
				u->build_queue.erase(u->build_queue.begin());
				partially_refund_unit_costs(u->owner, build_type);
				u_set_status_flag(u, unit_t::status_flag_completed);
				u_unset_status_flag(u, unit_t::status_flag_completed);
				auto hp = u->hp;
				finish_building_unit(u);
				complete_unit(u);
				set_unit_hp(u, hp);
				sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
				//play_sound(4, u);
			}
			else {
				partially_refund_unit_costs(u->owner, u);
				--st.total_non_buildings_ever_completed[u->owner];
				auto prev_hp = fp8::integer(u->previous_hp);
				if (unit_is(u, UnitTypes::Zerg_Extractor)) {
					unit_t* drone = create_unit(UnitTypes::Zerg_Drone, u->sprite->position, u->owner);
					if (drone) {
						finish_building_unit(drone);
						complete_unit(drone);
						set_unit_hp(drone, prev_hp);
					}
					kill_unit(u);
				}
				else {
					thingy_t* t = create_thingy(get_sprite_type(SpriteTypes::SPRITEID_Zerg_Building_Spawn_Small), u->sprite->position, 0);
					if (t) {
						t->sprite->elevation_level = u->sprite->elevation_level + 1;
						if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
					}
					const unit_type_t* build_type = u->unit_type;
					morph_unit(u, get_unit_type(UnitTypes::Zerg_Drone));
					finish_building_unit(u);
					complete_unit(u);
					if (u->sprite->images.back().modifier == 10) u->sprite->images.back().offset.y = 7;
					set_unit_order(u, get_order_type(Orders::ResetCollision));
					set_queued_order(u, false, u->unit_type->return_to_idle, {});
					set_unit_hp(u, prev_hp);
					remove_creep_provider(build_type, u->sprite->position, false);
					//play_sound(4, u);
				}
			}
		}

		void refund_unit_costs(int owner, unit_type_autocast unit_type) {
			// TODO
		}

		bool cancel_building_unit(unit_t* u) {
			if (unit_dying(u)) return false;
			if (u_completed(u)) return false;
			if (unit_is(u, UnitTypes::Zerg_Guardian)) return false;
			if (unit_is(u, UnitTypes::Zerg_Lurker)) return false;
			if (unit_is(u, UnitTypes::Zerg_Devourer)) return false;
			if (unit_is(u, UnitTypes::Zerg_Mutalisk)) return false;
			if (unit_is(u, UnitTypes::Zerg_Hydralisk)) return false;
			if (unit_is_nydus(u) && !u->building.nydus.exit) return false;
			if (u_grounded_building(u)) {
				if (unit_race(u) == race_t::zerg) {
					cancel_morphing_building(u);
					return true;
				}
				partially_refund_unit_costs(u->owner, u->unit_type);
			}
			else {
				const unit_type_t* refund_type = u->unit_type;
				if (unit_is_egg(u) && !u->build_queue.empty()) refund_type = u->build_queue.front();
				refund_unit_costs(u->owner, refund_type);
			}
			const unit_type_t* morph_to = nullptr;
			if (unit_is(u, UnitTypes::Zerg_Cocoon)) {
				morph_to = get_unit_type(UnitTypes::Zerg_Mutalisk);
			}
			else if (unit_is(u, UnitTypes::Zerg_Lurker_Egg)) {
				morph_to = get_unit_type(UnitTypes::Zerg_Hydralisk);
			}
			if (morph_to) {
				morph_unit(u, morph_to);
				if (!u->build_queue.empty()) u->build_queue.erase(u->build_queue.begin());
				u->remaining_build_time = 0;
				replace_sprite_images(u->sprite, u->previous_unit_type->flingy->sprite->image, 0_dir);
				u->order_signal &= ~4;
				sprite_run_anim(u->sprite, iscript_anims::SpecialState2);
				set_unit_order(u, get_order_type(Orders::ZergBirth));
			}
			else {
				if (unit_is(u, UnitTypes::Terran_Nuclear_Missile) && u->connected_unit) {
					if (unit_is_ghost(u->connected_unit)) {
						u->connected_unit->ghost.nuke_dot = nullptr;
					}
					u->connected_unit->order_state = 0;
				}
				kill_unit(u);
			}
			return true;
		}

		bool player_has_researched(int owner, TechTypes tech_id) const {
			return st.tech_researched.at(owner).at(tech_id);
		}


		void cancel_build_queue(unit_t* u, size_t index) {
			if (index >= u->build_queue.size()) return;
			const unit_type_t* unit_type = u->build_queue[index];
			u->build_queue.erase(u->build_queue.begin() + index);
			if (index != 0 || !u->current_build_unit) {
				if (!ut_building(unit_type)) {
					refund_unit_costs(u->owner, unit_type);
				}
			}
			else {
				cancel_building_unit(u->current_build_unit);
			}
		}

		void cancel_build_queue(unit_t* u) {
			while (!u->build_queue.empty()) cancel_build_queue(u, u->build_queue.size() - 1);
		}

		bool unit_is_researching(const unit_t* u) const {
			return u->building.researching_type != nullptr;
		}
		bool unit_is_upgrading(const unit_t* u) const {
			return u->building.upgrading_type != nullptr;
		}

		void cancel_research(unit_t* u, bool unit_destroyed = false) {
			if (!u->building.researching_type) return;
			auto* tech_type = u->building.researching_type;
			u->building.researching_type = nullptr;
			u->building.upgrade_research_time = 0;
			st.tech_researching[u->owner][tech_type->id] = false;
			if (!unit_destroyed) {
				sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
			}
		}

		void cancel_upgrade(unit_t* u, bool unit_destroyed = false) {
			if (!u->building.upgrading_type) return;
			auto* upgrade_type = u->building.upgrading_type;
			u->building.upgrading_type = nullptr;
			u->building.upgrade_research_time = 0;
			u->building.upgrading_level = 0;
			st.upgrade_upgrading[u->owner][upgrade_type->id] = false;
			if (!unit_destroyed) {
				sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
			}
		}

		void apply_upgrades_to_player_units(int owner) {
			for (unit_t* u : ptr(st.player_units[owner])) {
				update_unit_speed_upgrades(u);
			}
		}

		void give_unit_to(unit_t* u, int new_owner) {
			bool any_upgrades_granted = false;
			auto grant_tech = [&](TechTypes id) {
				if (!player_has_researched(new_owner, id)) st.tech_researched[new_owner][id] = true;
			};
			auto grant_upgrade = [&](UpgradeTypes id) {
				int level = player_upgrade_level(u->owner, id);
				if (player_upgrade_level(new_owner, id) < level) {
					any_upgrades_granted = true;
					st.upgrade_levels[new_owner][id] = level;
				}
			};
			switch (u->unit_type->id) {
			case UnitTypes::Terran_Marine:
				grant_upgrade(UpgradeTypes::U_238_Shells);
				grant_tech(TechTypes::Stim_Packs);
				break;
			case UnitTypes::Terran_Ghost:
				grant_upgrade(UpgradeTypes::Ocular_Implants);
				grant_upgrade(UpgradeTypes::Moebius_Reactor);
				grant_tech(TechTypes::Lockdown);
				grant_tech(TechTypes::Personnel_Cloaking);
				break;
			case UnitTypes::Terran_Vulture:
				grant_upgrade(UpgradeTypes::Ion_Thrusters);
				grant_tech(TechTypes::Spider_Mines);
				break;
			case UnitTypes::Terran_Goliath:
				grant_upgrade(UpgradeTypes::Charon_Boosters);
				break;
			case UnitTypes::Terran_Siege_Tank_Tank_Mode:
				grant_tech(TechTypes::Tank_Siege_Mode);
				break;
			case UnitTypes::Terran_Wraith:
				grant_upgrade(UpgradeTypes::Apollo_Reactor);
				grant_tech(TechTypes::Cloaking_Field);
				break;
			case UnitTypes::Terran_Science_Vessel:
				grant_upgrade(UpgradeTypes::Titan_Reactor);
				grant_tech(TechTypes::Defensive_Matrix);
				grant_tech(TechTypes::Irradiate);
				grant_tech(TechTypes::EMP_Shockwave);
				break;
			case UnitTypes::Terran_Battlecruiser:
				grant_upgrade(UpgradeTypes::Colossus_Reactor);
				grant_tech(TechTypes::Yamato_Gun);
				break;
			case UnitTypes::Terran_Siege_Tank_Siege_Mode:
				grant_tech(TechTypes::Tank_Siege_Mode);
				break;
			case UnitTypes::Terran_Firebat:
				grant_tech(TechTypes::Stim_Packs);
				break;
			case UnitTypes::Terran_Medic:
				grant_upgrade(UpgradeTypes::Caduceus_Reactor);
				grant_tech(TechTypes::Healing);
				grant_tech(TechTypes::Restoration);
				grant_tech(TechTypes::Optical_Flare);
				break;
			case UnitTypes::Zerg_Zergling:
				grant_upgrade(UpgradeTypes::Metabolic_Boost);
				grant_upgrade(UpgradeTypes::Adrenal_Glands);
				grant_tech(TechTypes::Burrowing);
				break;
			case UnitTypes::Zerg_Hydralisk:
				grant_upgrade(UpgradeTypes::Muscular_Augments);
				grant_upgrade(UpgradeTypes::Grooved_Spines);
				grant_tech(TechTypes::Burrowing);
				grant_tech(TechTypes::Lurker_Aspect);
				break;
			case UnitTypes::Zerg_Ultralisk:
				grant_upgrade(UpgradeTypes::Anabolic_Synthesis);
				grant_upgrade(UpgradeTypes::Chitinous_Plating);
				break;
			case UnitTypes::Zerg_Drone:
				grant_tech(TechTypes::Burrowing);
				break;
			case UnitTypes::Zerg_Overlord:
				grant_upgrade(UpgradeTypes::Ventral_Sacs);
				grant_upgrade(UpgradeTypes::Antennae);
				grant_upgrade(UpgradeTypes::Pneumatized_Carapace);
				break;
			case UnitTypes::Zerg_Queen:
				grant_upgrade(UpgradeTypes::Gamete_Meiosis);
				grant_tech(TechTypes::Infestation);
				grant_tech(TechTypes::Parasite);
				grant_tech(TechTypes::Spawn_Broodlings);
				grant_tech(TechTypes::Ensnare);
				break;
			case UnitTypes::Zerg_Defiler:
				grant_upgrade(UpgradeTypes::Metasynaptic_Node);
				grant_tech(TechTypes::Burrowing);
				grant_tech(TechTypes::Dark_Swarm);
				grant_tech(TechTypes::Plague);
				grant_tech(TechTypes::Consume);
				break;
			case UnitTypes::Zerg_Infested_Terran:
				grant_tech(TechTypes::Burrowing);
				break;
			case UnitTypes::Protoss_Corsair:
				grant_upgrade(UpgradeTypes::Argus_Jewel);
				grant_tech(TechTypes::Disruption_Web);
				break;
			case UnitTypes::Protoss_Dark_Templar:
				grant_tech(TechTypes::Dark_Archon_Meld);
				break;
			case UnitTypes::Protoss_Dark_Archon:
				grant_upgrade(UpgradeTypes::Argus_Talisman);
				grant_tech(TechTypes::Mind_Control);
				grant_tech(TechTypes::Feedback);
				grant_tech(TechTypes::Maelstrom);
				break;
			case UnitTypes::Protoss_Zealot:
				grant_upgrade(UpgradeTypes::Leg_Enhancements);
				break;
			case UnitTypes::Protoss_Dragoon:
				grant_upgrade(UpgradeTypes::Singularity_Charge);
				break;
			case UnitTypes::Protoss_High_Templar:
				grant_upgrade(UpgradeTypes::Khaydarin_Amulet);
				grant_tech(TechTypes::Archon_Warp);
				grant_tech(TechTypes::Psionic_Storm);
				grant_tech(TechTypes::Hallucination);
				break;
			case UnitTypes::Protoss_Shuttle:
				grant_upgrade(UpgradeTypes::Gravitic_Drive);
				break;
			case UnitTypes::Protoss_Scout:
				grant_upgrade(UpgradeTypes::Apial_Sensors);
				grant_upgrade(UpgradeTypes::Gravitic_Thrusters);
				break;
			case UnitTypes::Protoss_Arbiter:
				grant_upgrade(UpgradeTypes::Khaydarin_Core);
				grant_tech(TechTypes::Recall);
				grant_tech(TechTypes::Stasis_Field);
				break;
			case UnitTypes::Protoss_Carrier:
				grant_upgrade(UpgradeTypes::Carrier_Capacity);
				break;
			case UnitTypes::Protoss_Reaver:
				grant_upgrade(UpgradeTypes::Scarab_Damage);
				grant_upgrade(UpgradeTypes::Reaver_Capacity);
				break;
			case UnitTypes::Protoss_Observer:
				grant_upgrade(UpgradeTypes::Sensor_Array);
				grant_upgrade(UpgradeTypes::Gravitic_Boosters);
				break;
			case UnitTypes::Zerg_Lurker:
				grant_tech(TechTypes::Lurker_Aspect);
				break;
			default:
				break;
			}
			if (u_grounded_building(u)) {
				if (!u->build_queue.empty() && u->build_queue.front()->id <= UnitTypes::Spell_Disruption_Web) {
					cancel_build_queue(u);
					sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
				}
				if (unit_is_researching(u)) cancel_research(u);
				if (unit_is_upgrading(u)) cancel_upgrade(u);
			}
			if (unit_is_reaver(u) || unit_is_carrier(u)) cancel_build_queue(u);
			set_unit_owner(u, new_owner, true);
			if (new_owner < 8) set_sprite_owner(u, new_owner);
			if (any_upgrades_granted) apply_upgrades_to_player_units(new_owner);
			bool idle = u_completed(u);
			if (u_loaded(u)) idle = false;
			else if (u_grounded_building(u) && u->secondary_order_type->id == Orders::BuildAddon && u->current_build_unit && !u_completed(u->current_build_unit)) idle = false;
			else if (ut_powerup(u)) idle = false;
			else if (unit_is_fighter(u)) idle = false;
			else if (unit_is(u, UnitTypes::Terran_Nuclear_Missile)) idle = false;
			if (idle) {
				set_unit_order(u, u->unit_type->human_ai_idle);
			}

		}

		void make_unit_neutral(unit_t* u) {
			if (u->secondary_order_type->id == Orders::BuildAddon && u_grounded_building(u) && u->current_build_unit) {
				if (!u_completed(u->current_build_unit)) cancel_building_unit(u->current_build_unit);
			}
			give_unit_to(u, 11);
			if (!u_hallucination(u)) set_secondary_order(u, get_order_type(Orders::Nothing));
		}

		void building_abandon_addon(unit_t* u) {
			unit_t* addon = u->building.addon;
			if (!addon) return;
			make_unit_neutral(addon);
			u->building.addon = nullptr;
			// todo: callback for sound
			auto ius = make_thingy_setter(iscript_unit, addon);
			sprite_run_anim(addon->sprite, iscript_anims::LiftOff);
		}

		xy get_image_map_position(const image_t* image) const {
			// TODO
			xy map_pos = image->sprite->position + image->offset;
			if (image->flags & image_t::flag_y_frozen) map_pos.y = image->frozen_y_value;
			return map_pos;
		}

		void order_BuildingLiftoff(unit_t* u) {
			if (!u_grounded_building(u) || !ut_flying_building(u)) {
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
				return;
			}
			if (u->building.addon) building_abandon_addon(u);
			set_unit_tiles_unoccupied(u, u->sprite->position);
			u_unset_status_flag(u, unit_t::status_flag_grounded_building);
			u_set_status_flag(u, unit_t::status_flag_can_turn);
			u_set_status_flag(u, unit_t::status_flag_can_move, !ut_turret(u));
			u_set_status_flag(u, unit_t::status_flag_flying);
			u->sprite->elevation_level = 12;
			reset_movement_state(u);
			check_unit_collision(u);
			if (u->sprite->images.back().modifier == 10) {
				u->sprite->images.back().frozen_y_value = get_image_map_position(&u->sprite->images.back()).y;
				u->sprite->images.back().flags |= image_t::flag_y_frozen;
			}
			set_next_target_waypoint(u, u->sprite->position - xy(0, 42));
			if (unit_is(u, UnitTypes::Zerg_Infested_Command_Center)) remove_creep_provider(u);
			u->order_type = get_order_type(Orders::LiftingOff);
		}

		void create_dust_sprite(sprite_t* sprite, SpriteTypes sprite_id, size_t lo_index, size_t offset_from, size_t offset_to, bool flipped) {
			for (size_t i = offset_from; i != offset_to + 1; ++i) {
				xy offset = get_image_lo_offset(sprite->main_image, lo_index, i);
				if (offset.x != 127 && offset.y != 127) {
					// TODO: Factorio Create dust simple-smoke
					auto* t = create_thingy(get_sprite_type(sprite_id), sprite->position + offset, 0);
					if (t) {
						t->sprite->elevation_level = sprite->elevation_level + 1;
						if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
						if (flipped) {
							for (auto* image : ptr(t->sprite->images)) {
								set_image_frame_index_offset(image, image->frame_index_offset, true);
							}
						}
					}
				}
				sprite_id = SpriteTypes((int)sprite_id + 1);
			}
		}

		void order_LiftingOff(unit_t* u) {
			if (u->order_state == 0 || u->order_state == 1) {
				if (u->order_state == 0) {
					if (u->position != u->next_target_waypoint && u->next_velocity_direction != xy_direction(u->next_target_waypoint - u->sprite->position)) {
						return;
					}
					u->order_state = 1;
				}
				xy pos = u->sprite->position + xy(0, u->sprite->images.back().offset.y - (ut_worker(u) ? 7 : 42));
				set_unit_move_target(u, pos);
				set_next_target_waypoint(u, pos);
				u->order_state = 2;
			}
			else if (u->order_state == 2 || u->order_state == 3) {
				if (u->order_state == 2) {
					sprite_run_anim(u->sprite, iscript_anims::LiftOff);
					if (u->sprite->main_image->image_type->lift_off_filename_index) {
						create_dust_sprite(u->sprite, SpriteTypes::SPRITEID_Building_Landing_Dust_Type1, 4, 0, 8, false);
						create_dust_sprite(u->sprite, SpriteTypes::SPRITEID_Building_Landing_Dust_Type1, 4, 16, 24, true);
					}
					u->flingy_top_speed = fp8::integer(1);
					set_next_speed(u, fp8::integer(1));
					u->order_state = 3;
				}
				if (unit_is_at_move_target(u)) {
					if (u->order_signal & 0x10) {
						u->order_signal &= ~0x10;
						if (!ut_building(u)) u->flingy_top_speed = get_modified_unit_speed(u, u->flingy_type->top_speed);
						if (u->sprite->images.back().modifier == 10) {
							u->sprite->images.back().offset.y = (ut_worker(u) ? 7 : 42);
							u->sprite->images.back().flags &= ~image_t::flag_y_frozen;
						}
						u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
						order_done(u);
					}
				}
			}
		}

		void order_PlaceAddon(unit_t* u) {
			const unit_type_t* addon_type = u->building.addon_build_type;
			if (!addon_type || !ut_addon(addon_type)) return;
			if (u->order_state == 0) {
				if (u_grounded_building(u)) {
					if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() == 0) {
						set_unit_move_target(u, u->order_target.pos);
						set_next_target_waypoint(u, u->order_target.pos);
						u->order_state = 1;
					}
					else {
						set_unit_order(u, get_order_type(Orders::BuildingLiftoff), u->order_target.pos);
						set_queued_order(u, false, get_order_type(Orders::PlaceAddon), u->order_target.pos);
					}
				}
				else {
					set_unit_order(u, get_order_type(Orders::BuildingLand), u->order_target.pos);
					set_queued_order(u, false, get_order_type(Orders::PlaceAddon), u->order_target.pos);
				}
			}
			if (u->order_state == 1 && unit_is_at_move_target(u)) {
				u->order_target.pos -= u->unit_type->placement_size / 2;
				u->order_target.pos += addon_type->addon_position;
				u->order_target.pos += addon_type->placement_size / 2;
				if (!player_has_supply_and_resources_for(u->owner, addon_type)) {
					order_done(u);
				}
				else if (!can_place_building(u, u->owner, addon_type, u->order_target.pos, true, false)) {
					order_done(u);
				}
				else {
					unit_t* addon = create_unit(addon_type, u->order_target.pos, u->owner);
					if (addon) {
						set_unit_order(u, u->unit_type->return_to_idle);
						set_secondary_order(u, get_order_type(Orders::BuildAddon));
						u->current_build_unit = addon;
						set_unit_order(addon, get_order_type(Orders::IncompleteBuilding));
						addon->connected_unit = u;
					}
				}
			}
		}

		bool unit_can_move(const unit_t* u) const {
			if (u_grounded_building(u)) return false;
			if (u->unit_type->right_click_action == 0) return false;
			if (u->unit_type->right_click_action == 3) return false;
			if (unit_is(u, UnitTypes::Zerg_Lurker) && u_burrowed(u)) return false;
			return true;
		}
		void order_BuildingLand(unit_t* u) {
			if (u_grounded_building(u)) {
				set_unit_order(u, get_order_type(Orders::BuildingLiftoff), u->order_target.pos);
				set_queued_order(u, false, get_order_type(Orders::BuildingLand), u->order_target.pos);
			}
			else {
				if (u->order_state == 0) {
					xy pos = u->order_target.pos - xy(0, u->sprite->images.back().offset.y);
					set_unit_move_target(u, pos);
					set_next_target_waypoint(u, pos);
					u->order_state = 1;
				}
				else if (u->order_state == 1) {
					if (unit_is_at_move_target(u)) {
						if (!can_place_building(u, u->owner, u->unit_type, u->order_target.pos, true, false)) {
							if (!u->order_queue.empty() && u->order_queue.front().order_type->id == Orders::PlaceAddon) {
								remove_queued_order(u, &u->order_queue.front());
							}
							order_done(u);
						}
						else {
							set_unit_tiles_occupied(u, u->order_target.pos);
							u->building.is_landing = true;
							set_unit_move_target(u, u->order_target.pos);
							set_next_target_waypoint(u, u->order_target.pos);
							if (u->sprite->images.back().modifier == 10) {
								u->sprite->images.back().frozen_y_value = get_image_map_position(&u->sprite->images.back()).y;
								u->sprite->images.back().flags |= image_t::flag_y_frozen;
							}
							u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
							u->flingy_top_speed = fp8::integer(1);
							set_next_speed(u, fp8::integer(1));
							u->order_state = 2;
						}
					}
				}
				else if (u->order_state == 2) {
					if (u->position == u->next_target_waypoint || u->next_velocity_direction == xy_direction(u->next_target_waypoint - u->sprite->position)) {
						sprite_run_anim(u->sprite, iscript_anims::Landing);
						u->order_state = 3;
					}
				}
				if (u->order_state == 3) {
					if (u->order_signal & 0x10 && unit_is_at_move_target(u)) {
						u->order_signal &= ~0x10;
						if (u_flying(u)) decrement_repulse_field(u);
						u_unset_status_flag(u, unit_t::status_flag_flying);
						u_unset_status_flag(u, unit_t::status_flag_can_turn);
						u_unset_status_flag(u, unit_t::status_flag_can_move);
						u_set_status_flag(u, unit_t::status_flag_grounded_building);
						u->sprite->elevation_level = 4;
						reset_movement_state(u);
						move_unit(u, u->order_target.pos);
						check_unit_collision(u);
						u->sprite->images.back().offset.y = 0;
						if (u->sprite->images.back().modifier == 10) u->sprite->images.back().flags &= ~image_t::flag_y_frozen;
						if (u->sprite->main_image->image_type->landing_dust_filename_index) {
							create_dust_sprite(u->sprite, SpriteTypes::SPRITEID_Building_Landing_Dust_Type1, 3, 0, 8, false);
							create_dust_sprite(u->sprite, SpriteTypes::SPRITEID_Building_Landing_Dust_Type1, 3, 16, 24, true);
						}
						u->building.is_landing = false;
						for (unit_t* n : find_units_noexpand(unit_sprite_inner_bounding_box(u))) {
							if (n == u) continue;
							if (unit_target_is_enemy(n, u)) continue;
							if ((!unit_can_move(u) && unit_can_attack(u)) || u_burrowed(u)) kill_unit(n);
						}
						if (!u->order_queue.empty()) {
							auto* o = &u->order_queue.front();
							if (o->order_type->id == Orders::Move || o->order_type->id == Orders::Follow) {
								queue_order_front(u, get_order_type(Orders::BuildingLiftoff), {});
							}
							else {
								while (!u->order_queue.empty() && u->order_queue.back().order_type->id != Orders::PlaceAddon) {
									remove_queued_order(u, &u->order_queue.back());
								}
								if (u->order_queue.empty()) set_unit_order(u, u->unit_type->return_to_idle);
							}
						}
						for (unit_t* n : find_units_noexpand(unit_sprite_inner_bounding_box(u))) {
							if (n == u) continue;
							if (u_grounded_building(n) || !unit_can_move(n)) {
								if (unit_can_attack(n) && n->order_type->id != Orders::Die) {
									set_unit_order(u, get_order_type(Orders::BuildingLiftoff));
									set_queued_order(u, false, u->unit_type->return_to_idle, {});
									break;
								}
							}
						}
						u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
						order_done(u);
						find_and_connect_addon(u);
					}
				}
			}
		}

		void order_ResearchTech(unit_t* u) {
			auto* tech = u->building.researching_type;
			auto done = [&]() {
				u->building.researching_type = nullptr;
				if (tech) st.tech_researching[u->owner][tech->id] = false;
				sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
				order_done(u);
			};
			if (!tech) {
				done();
				return;
			}
			if (u->building.upgrade_research_time-- == 0 || player_has_researched(u->owner, tech->id)) {
				// todo: callback for sound
				st.tech_researched[u->owner][tech->id] = true;
				done();
			}
		}

		int player_max_upgrade_level(int owner, UpgradeTypes upgrade_id) const {
			return game_st.max_upgrade_levels.at(owner).at(upgrade_id);
		}
		void order_Upgrade(unit_t* u) {
			auto* upgrade = u->building.upgrading_type;
			auto done = [&]() {
				u->building.upgrading_type = nullptr;
				u->building.upgrading_level = 0;
				if (upgrade) st.upgrade_upgrading[u->owner][upgrade->id] = false;
				sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
				order_done(u);
			};
			if (!u_grounded_building(u) || !upgrade) {
				done();
				return;
			}
			bool already_upgraded = player_upgrade_level(u->owner, upgrade->id) >= u->building.upgrading_level;
			if (u->building.upgrade_research_time-- == 0 || already_upgraded) {
				// todo: callback for sound
				if (!already_upgraded && player_max_upgrade_level(u->owner, upgrade->id) >= u->building.upgrading_level) {
					st.upgrade_levels[u->owner][upgrade->id] = u->building.upgrading_level;
					apply_upgrades_to_player_units(u->owner);
				}
				done();
			}
		}

		bool unit_is_goliath(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Goliath)) return true;
			if (unit_is(ut, UnitTypes::Hero_Alan_Schezar)) return true;
			return false;
		}

		void order_StayInRange(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
			u->order_target.pos = target->sprite->position;
			if (!unit_can_attack_target(u, target)) {
				if (!u_ready_to_attack(u)) queue_order_front(u, get_order_type(Orders::Move), u->order_target.pos);
				order_done(u);
				return;
			}
			if (u->order_state == 0) {
				if (!unit_target_in_weapon_movement_range(u, target)) {
					move_to_target(u, target);
				}
				u->order_state = 1;
			}
			else {
				if (!unit_target_in_weapon_movement_range(u, target)) {
					if (!try_follow_unit(u, target)) return;
				}
				else {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
				}
			}
			if (unit_is_goliath(u) && !u_movement_flag(u, 2)) {
				auto heading_error = fp8::extend(xy_direction(u->order_target.pos - u->sprite->position) - u->heading).abs();
				if (heading_error >= 32_fp8) set_next_target_waypoint(u, u->order_target.pos);
			}
		}

		void order_TurretAttack(unit_t* u) {
			attack_unit_reacquire_target(u);
			unit_t* target = u->order_target.unit;
			if (target) u->order_target.pos = target->sprite->position;
			if (!unit_can_attack_target(u, target) || !unit_can_see_target(u, target)) {
				set_unit_order(u, get_order_type(Orders::TurretGuard));
				return;
			}
			bool attack = false;
			if (unit_can_see_target(u, target)) {
				if (unit_target_in_weapon_movement_range(u, target)) {
					attack = true;
				}
			}
			if (!attack && (u->subunit->order_type != u->subunit->unit_type->attack_unit || unit_is_immovable_attacker(u->subunit))) {
				set_unit_order(u, get_order_type(Orders::TurretGuard));
			}
			else {
				attack = true;
			}
			if (attack) {
				set_next_target_waypoint(u, u->order_target.pos);
				if (!u_movement_flag(u->subunit, 2)) attack_unit_fire_weapon(u);
			}
		}

		bool unit_is_unsieged_tank(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Siege_Tank_Tank_Mode)) return true;
			if (unit_is(ut, UnitTypes::Hero_Edmund_Duke_Tank_Mode)) return true;
			return false;
		}

		void order_Sieging(unit_t* u) {
			if (u->order_state == 0) {
				if (!unit_is_unsieged_tank(u)) {
					order_done(u);
					return;
				}
				if (u_movement_flag(u, 2)) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
				}
				u->order_state = 1;
			}
			unit_t* turret = unit_turret(u);
			if (u->order_state == 1) {
				if (!u_movement_flag(u, 2) && !u_movement_flag(turret, 2) && !u_iscript_nobrk(turret)) {
					set_next_target_waypoint(u, to_xy(u->exact_position + direction_xy(8_dir * u->unit_type->unit_direction, 16)));
					set_next_target_waypoint(turret, to_xy(turret->exact_position + direction_xy(8_dir * turret->unit_type->unit_direction, 16)));
					set_unit_order(turret, get_order_type(Orders::NothingWait), u);
					auto ius = make_thingy_setter(iscript_unit, turret);
					sprite_run_anim(turret->sprite, iscript_anims::SpecialState1);
					u->order_state = 2;
					for (unit_t* n : find_units(unit_sprite_inner_bounding_box(u))) {
						if (n == u) continue;
						if (!u_grounded_building(n)) continue;
						if (u_no_collide(n)) continue;
						kill_unit(u);
						return;
					}
				}
			}
			if (u->order_state == 2) {
				if (is_facing_next_target_waypoint(u) && is_facing_next_target_waypoint(turret)) {
					if (unit_is(u, UnitTypes::Terran_Siege_Tank_Tank_Mode)) {
						morph_unit(u, get_unit_type(UnitTypes::Terran_Siege_Tank_Siege_Mode));
					}
					else if (unit_is(u, UnitTypes::Hero_Edmund_Duke_Tank_Mode)) {
						morph_unit(u, get_unit_type(UnitTypes::Hero_Edmund_Duke_Siege_Mode));
					}
					u->order_state = 3;
				}
			}
			if (u->order_state == 3) {
				if (u->order_signal & 1) {
					u->order_signal &= ~1;
					if (!u->order_queue.empty() && u->order_queue.front().order_type->id != Orders::WatchTarget) {
						set_unit_order(u, u->unit_type->return_to_idle);
					}
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
					u_unset_status_flag(turret, unit_t::status_flag_order_not_interruptible);
					order_done(turret);
				}
			}
		}

		bool unit_is_sieged_tank(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Siege_Tank_Siege_Mode)) return true;
			if (unit_is(ut, UnitTypes::Hero_Edmund_Duke_Siege_Mode)) return true;
			return false;
		}

		void order_Unsieging(unit_t* u) {
			unit_t* turret = unit_turret(u);
			if (u->order_state == 0) {
				if (!unit_is_sieged_tank(u)) {
					order_done(u);
					return;
				}
				if (!u_iscript_nobrk(turret)) {
					set_unit_order(turret, get_order_type(Orders::NothingWait), u);
					set_next_target_waypoint(turret, to_xy(turret->exact_position + direction_xy(8_dir * turret->unit_type->unit_direction, 16)));
					auto ius = make_thingy_setter(iscript_unit, turret);
					sprite_run_anim(turret->sprite, iscript_anims::SpecialState1);
					u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				if (is_facing_next_target_waypoint(turret)) {
					sprite_run_anim(u->sprite, iscript_anims::SpecialState2);
					auto ius = make_thingy_setter(iscript_unit, turret);
					sprite_run_anim(turret->sprite, iscript_anims::SpecialState2);
					u->order_signal &= ~1;
					u->order_state = 3;
				}
			}
			if (u->order_state == 3) {
				if (u->order_signal & 1) {
					u->order_signal &= ~1;
					if (unit_is(u, UnitTypes::Terran_Siege_Tank_Siege_Mode)) {
						morph_unit(u, get_unit_type(UnitTypes::Terran_Siege_Tank_Tank_Mode));
					}
					else if (unit_is(u, UnitTypes::Hero_Edmund_Duke_Siege_Mode)) {
						morph_unit(u, get_unit_type(UnitTypes::Hero_Edmund_Duke_Tank_Mode));
					}
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
					u_unset_status_flag(turret, unit_t::status_flag_order_not_interruptible);
					order_done(turret);
				}
			}
		}

		bool unit_is_immovable_attacker(const unit_t* u) const {
			if (unit_is(u, UnitTypes::Zerg_Lurker) && u_burrowed(u)) return true;
			if (u->unit_type->right_click_action == 3) return true;
			return false;
		}

		void order_WatchTarget(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!unit_can_attack_target(u, target)) {
				order_done(u, u->order_target.pos);
				return;
			}
			if (!unit_can_see_target(u, target) || !unit_target_in_weapon_movement_range(u, target)) {
				if (unit_is_immovable_attacker(u)) {
					order_done(u, u->order_target.pos);
					return;
				}
			}
		}

		void order_PickupIdle(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (target) {
				queue_order_front(u, get_order_type(Orders::PickupTransport), { target->sprite->position, target });
				activate_next_order(u);
			}
		}

		void order_PickupTransport(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				order_done(u);
				return;
			}
			if (!unit_can_load_target(u, target)) {
				order_done(u);
				return;
			}
			if (u->main_order_timer == 0) {
				u->main_order_timer = 7;
				if (unit_target_in_range(u, target, 1)) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					if (target->order_type->id != Orders::EnterTransport && target->order_type->id != Orders::Pickup4) {
						set_unit_order(target, get_order_type(Orders::EnterTransport), u);
					}
					queue_order_front(u, get_order_type(Orders::PickupIdle), { target->sprite->position, target });
					activate_next_order(u);
				}
				else {
					move_to_target_reset(u, target);
				}
			}
		}

		void order_MoveUnload(unit_t* u) {
			if (u->order_state == 0) {
				if (u->order_target.unit) {
					u->order_target.pos = u->order_target.unit->sprite->position;
					u->order_target.unit = nullptr;
					u->order_state = 1;
				}
			}
			if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= 16) {
				queue_order_front(u, get_order_type(Orders::Unload), {});
				activate_next_order(u);
			}
			else {
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
			}
		}

		bool unit_is_defiler(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Zerg_Defiler)) return true;
			if (unit_is(ut, UnitTypes::Hero_Unclean_One)) return true;
			return false;
		}

		bool player_tech_available(int owner, TechTypes tech_id) const {
			return game_st.tech_available.at(owner).at(tech_id);
		}
		bool unit_is_marine(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Marine)) return true;
			if (unit_is(ut, UnitTypes::Hero_Jim_Raynor_Marine)) return true;
			return false;
		}

		bool unit_is_firebat(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Firebat)) return true;
			if (unit_is(ut, UnitTypes::Hero_Gui_Montag)) return true;
			return false;
		}

		bool unit_is_wraith(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Terran_Wraith)) return true;
			if (unit_is(ut, UnitTypes::Hero_Tom_Kazansky)) return true;
			return false;
		}

		bool unit_is_tank(unit_type_autocast ut) const {
			return unit_is_sieged_tank(ut) || unit_is_unsieged_tank(ut);
		}

		size_t unit_spider_mine_count(const unit_t* u) const {
			if (!unit_is_vulture(u)) return 0;
			return u->vulture.spider_mine_count;
		}

		bool unit_can_use_tech(const unit_t* u, const tech_type_t* tech) const {
			if (!u_completed(u)) return false;
			if (u_hallucination(u)) return false;
			if (unit_is_disabled(u)) return false;
			int owner = u->owner;
			if (!player_tech_available(owner, tech->id)) return false;
			switch (tech->id) {
			case TechTypes::Stim_Packs:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Stim_Packs)) return false;
				if (!unit_is_marine(u) && !unit_is_firebat(u)) return false;
				return true;
			case TechTypes::Lockdown:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Lockdown)) return false;
				if (!unit_is_ghost(u)) return false;
				return true;
			case TechTypes::Spider_Mines:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Spider_Mines)) return false;
				if (unit_spider_mine_count(u) == 0) return false;
				if (!unit_is_vulture(u)) return false;
				return true;
			case TechTypes::Scanner_Sweep:
				if (!unit_is(u, UnitTypes::Terran_Comsat_Station)) return false;
				return true;
			case TechTypes::Tank_Siege_Mode:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Tank_Siege_Mode)) return false;
				if (!unit_is_tank(u)) return false;
				return true;
			case TechTypes::EMP_Shockwave:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::EMP_Shockwave)) return false;
				if (!unit_is(u, UnitTypes::Terran_Science_Vessel) && !unit_is(u, UnitTypes::Hero_Magellan)) return false;
				return true;
			case TechTypes::Defensive_Matrix:
				if (!unit_is(u, UnitTypes::Terran_Science_Vessel) && !unit_is(u, UnitTypes::Hero_Magellan)) return false;
				return true;
			case TechTypes::Irradiate:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Irradiate)) return false;
				if (!unit_is(u, UnitTypes::Terran_Science_Vessel) && !unit_is(u, UnitTypes::Hero_Magellan)) return false;
				return true;
			case TechTypes::Yamato_Gun:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Yamato_Gun)) return false;
				if (!unit_is(u, UnitTypes::Terran_Battlecruiser) && !unit_is(u, UnitTypes::Hero_Hyperion) && !unit_is(u, UnitTypes::Hero_Norad_II) && !unit_is(u, UnitTypes::Hero_Gerard_DuGalle)) return false;
				return true;
			case TechTypes::Cloaking_Field:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Cloaking_Field)) return false;
				if (!unit_is_wraith(u)) return false;
				return true;
			case TechTypes::Personnel_Cloaking:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Personnel_Cloaking)) return false;
				if (!unit_is_ghost(u)) return false;
				return true;
			case TechTypes::Restoration:
				if (!player_has_researched(owner, TechTypes::Restoration)) return false;
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				return true;
			case TechTypes::Healing:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				return true;
			case TechTypes::Burrowing:
				if (!ut_hero(u) && !unit_is(u, UnitTypes::Zerg_Lurker) && !player_has_researched(owner, TechTypes::Burrowing)) return false;
				if (!unit_is(u, UnitTypes::Zerg_Lurker) && !unit_is(u, UnitTypes::Zerg_Drone) && !unit_is(u, UnitTypes::Zerg_Infested_Terran) && !unit_is(u, UnitTypes::Zerg_Defiler) && !unit_is(u, UnitTypes::Zerg_Zergling) && !unit_is(u, UnitTypes::Zerg_Hydralisk) && !unit_is(u, UnitTypes::Hero_Unclean_One) && !unit_is(u, UnitTypes::Hero_Devouring_One) && !unit_is(u, UnitTypes::Hero_Hunter_Killer)) return false;
				return true;
			case TechTypes::Infestation:
				if (!unit_is_queen(u)) return false;
				return true;
			case TechTypes::Spawn_Broodlings:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Spawn_Broodlings)) return false;
				if (!unit_is_queen(u)) return false;
				return true;
			case TechTypes::Parasite:
				if (!unit_is_queen(u)) return false;
				return true;
			case TechTypes::Dark_Swarm:
				if (!unit_is_defiler(u)) return false;
				if (u_burrowed(u)) return false;
				return true;
			case TechTypes::Plague:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Plague)) return false;
				if (!unit_is_defiler(u)) return false;
				if (u_burrowed(u)) return false;
				return true;
			case TechTypes::Consume:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Consume)) return false;
				if (!unit_is_defiler(u) && !unit_is(u, UnitTypes::Hero_Infested_Duran) && !unit_is(u, UnitTypes::Hero_Infested_Kerrigan)) return false;
				if (u_burrowed(u)) return false;
				return true;
			case TechTypes::Ensnare:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Ensnare)) return false;
				if (!unit_is_queen(u) && !unit_is(u, UnitTypes::Hero_Infested_Kerrigan)) return false;
				if (u_burrowed(u)) return false;
				return true;
			case TechTypes::Psionic_Storm:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Psionic_Storm)) return false;
				if (!unit_is(u, UnitTypes::Protoss_High_Templar) && !unit_is(u, UnitTypes::Hero_Tassadar) && !unit_is(u, UnitTypes::Hero_Infested_Kerrigan)) return false;
				return true;
			case TechTypes::Hallucination:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Hallucination)) return false;
				if (!unit_is(u, UnitTypes::Protoss_High_Templar) && !unit_is(u, UnitTypes::Hero_Tassadar)) return false;
				return true;
			case TechTypes::Archon_Warp:
				if (!unit_is(u, UnitTypes::Protoss_High_Templar)) return false;
				return true;
			case TechTypes::Recall:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Recall)) return false;
				if (!unit_is_arbiter(u)) return false;
				return true;
			case TechTypes::Stasis_Field:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Stasis_Field)) return false;
				if (!unit_is_arbiter(u)) return false;
				return true;
			case TechTypes::Disruption_Web:
				if (!ut_hero(u) && !player_has_researched(owner, TechTypes::Disruption_Web)) return false;
				if (!unit_is(u, UnitTypes::Protoss_Corsair) && !unit_is(u, UnitTypes::Hero_Raszagal)) return false;
				return true;
			case TechTypes::Dark_Archon_Meld:
				if (!unit_is(u, UnitTypes::Protoss_Dark_Templar)) return false;
				return true;
			case TechTypes::Mind_Control:
				if (!player_has_researched(owner, TechTypes::Mind_Control)) return false;
				if (!unit_is(u, UnitTypes::Protoss_Dark_Archon)) return false;
				return true;
			case TechTypes::Feedback:
				if (!unit_is(u, UnitTypes::Protoss_Dark_Archon)) return false;
				return true;
			case TechTypes::Optical_Flare:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				if (!player_has_researched(owner, TechTypes::Optical_Flare)) return false;
				return true;
			case TechTypes::Maelstrom:
				if (!player_has_researched(owner, TechTypes::Maelstrom)) return false;
				if (!unit_is(u, UnitTypes::Protoss_Dark_Archon)) return false;
				return true;
			case TechTypes::Lurker_Aspect:
				if (!player_has_researched(owner, TechTypes::Lurker_Aspect)) return false;
				if (!unit_is(u, UnitTypes::Zerg_Hydralisk)) return false;
				return true;
			default:
				return false;
			}
		}

		void order_PlaceMine(unit_t* u) {
			if (u->order_state == 0) {
				unit_t* target = u->order_target.unit;
				if (target) {
					move_to_target(u, target);
					set_next_target_waypoint(u, target->sprite->position);
					u->order_target.pos = target->sprite->position;
				}
				else {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
				}
				u->order_state = 1;
			}
			else {
				if (!unit_can_use_tech(u, get_tech_type(TechTypes::Spider_Mines)) || (unit_is_at_move_target(u) && u_immovable(u))) {
					order_done(u);
					return;
				}
				if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= 20) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					xy pos = u->order_target.pos;
					unit_t* mine = create_unit(UnitTypes::Terran_Vulture_Spider_Mine, pos, u->owner);
					if (mine) {
						finish_building_unit(mine);
						complete_unit(mine);
						set_unit_heading(mine, u->heading);
						--u->vulture.spider_mine_count;
					}
					order_done(u);
				}
			}
		}

		void set_unit_burrowed(unit_t* u) {
			reset_movement_state(u);
			u_set_status_flag(u, unit_t::status_flag_burrowed);
			u_set_status_flag(u, unit_t::status_flag_passively_cloaked);
			u->sprite->flags |= sprite_t::flag_burrowed;
			u->sprite->elevation_level = 1;
			if (unit_is(u, UnitTypes::Zerg_Lurker)) {
				u->sprite->sprite_type = get_sprite_type(SpriteTypes::SPRITEID_White_Circle2);
			}
			else {
				u->sprite->sprite_type = get_sprite_type(SpriteTypes::SPRITEID_White_Circle_Invisible);
			}
		}

		void crappy_move_to_target(unit_t* u, const unit_t* target) {
			xy target_pos = target->sprite->position;
			int speed = (u->flingy_top_speed * 2).integer_part();
			if (target->position != target->move_target.pos && speed != 0) {
				if (u_movement_flag(target, 4)) {
					target_pos = target->move_target.pos;
				}
				else {
					auto distance = [&](xy vec) {
						unsigned int x = std::abs(vec.x);
						unsigned int y = std::abs(vec.y);
						if (x < y) std::swap(x, y);
						if (x / 4 < y) return x + x / 32 + y * 3 / 8 - x / 32 + y * 3 / 64 - x / 128 + y * 3 / 256;
						else return x + x / 32 + y * 3 / 256;
					};
					int t = distance(target->sprite->position - u->sprite->position) / speed;
					fp8 pred_speed;
					if (u->flingy_movement_type == 2) pred_speed = target->flingy_top_speed;
					else pred_speed = std::min(target->next_speed + target->flingy_acceleration * t / 2, target->flingy_top_speed);
					auto pred_distance = pred_speed * t;
					target_pos = target->sprite->position + to_xy(direction_xy(target->next_velocity_direction, pred_distance));
				}
			}
			set_flingy_move_target(u, target_pos);
			set_next_target_waypoint(u, target_pos);
		}

		void order_SpiderMine(unit_t* u) {
			if (u->order_state == 0) {
				u->ground_weapon_cooldown = 60;
				u->order_state = 1;
			}
			if (u->order_state == 1) {
				if (u->ground_weapon_cooldown == 0) {
					sprite_run_anim(u->sprite, iscript_anims::Burrow);
					u_set_status_flag(u, unit_t::status_flag_no_collide);
					u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					if (!u_hallucination(u)) {
						set_unit_burrowed(u);
						set_unit_cloaked(u);
						set_sprite_cloak_modifier(u->sprite, true, true, true, 0, 0);
						u_set_status_flag(u, unit_t::status_flag_cloaked);
						u_set_status_flag(u, unit_t::status_flag_requires_detector);
						u->detected_flags = 0x80000000;
						u->secondary_order_timer = 0;
						set_secondary_order(u, get_order_type(Orders::Cloak));
					}
					u->order_state = 3;
				}
			}
			if (u->order_state == 3) {
				if (!u_cannot_attack(u)) {
					int range = 32 * unit_target_acquisition_range(u);
					unit_t* target = find_nearest_unit(u, square_at(u->sprite->position, range), [&](unit_t* target) {
						if (target == u) return false;
						if (!unit_target_is_enemy(u, target)) return false;
						if (u_invincible(target)) return false;
						if (u_grounded_building(target)) return false;
						if (u_flying(target)) return false;
						if (target->unit_type->unknown1 == 0xc1) return false; // hovering?
						return true;
						});
					if (target) {
						u->order_target.unit = target;
						sprite_run_anim(u->sprite, iscript_anims::UnBurrow);
						u->sprite->flags &= ~0x40;
						set_secondary_order(u, get_order_type(Orders::Nothing));
						u->order_state = 4;
					}
				}
			}
			unit_t* target = u->order_target.unit;
			if (u->order_state == 4) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					u->sprite->elevation_level = u->unit_type->elevation_level;
					u_unset_status_flag(u, unit_t::status_flag_no_collide);
					if (target) {
						crappy_move_to_target(u, target);
						u->order_state = 5;
					}
					else {
						u->order_state = 1;
					}
				}
			}
			else if (u->order_state == 5) {
				reset_movement_state(u);
				u_unset_status_flag(u, unit_t::status_flag_passively_cloaked);
				u_unset_status_flag(u, unit_t::status_flag_burrowed);
				u->sprite->sprite_type = u->unit_type->flingy->sprite;
				if (target && unit_target_in_range(u, target, 576)) {
					crappy_move_to_target(u, target);
					if (unit_target_in_range(u, target, 30)) {
						u->order_target.pos = u->sprite->position;
						u->order_target.unit = nullptr;
						sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
						u->order_state = 6;
					}
					else if (unit_is_at_move_target(u) && u_immovable(u)) {
						stop_unit(u);
						u->order_state = 1;
					}
				}
				else {
					stop_unit(u);
					u->order_state = 1;
				}
			}
			if (u->order_state == 6) {
				if (u->order_signal & 1) kill_unit(u);
			}
		}

		void order_Critter(unit_t* u) {
			if (u->order_state == 0) {
				direction_t dir = direction_from_index(lcg_rand(48, 0, 255));
				int distance = 32;
				if (unit_is(u, UnitTypes::Critter_Kakaru)) distance = lcg_rand(48, 160, 640);
				xy target_pos = u->sprite->position + to_xy(direction_xy(dir, distance));
				u->order_target.pos = target_pos;
				set_unit_move_target(u, target_pos);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (unit_is(u, UnitTypes::Critter_Kakaru)) u->order_state = 0;
					else if (u_immovable(u)) {
						u->main_order_timer = 75;
						u->order_state = 2;
					}
					else {
						u->main_order_timer = lcg_rand(47, 0, 75);
						if (u->main_order_timer <= 15) u->main_order_timer = 0;
						u->order_state = 2;
					}
				}
			}
			else if (u->order_state == 2) {
				if (u->main_order_timer == 0) {
					u->order_state = 0;
				}
			}
		}
		void create_bunker_fire_animation(unit_t* u) {
			const sprite_type_t* sprite;
			size_t index = (direction_index(u->heading) + 16) / 32 & 7;
			direction_t heading;
			if (unit_is_firebat(u)) {
				sprite = get_sprite_type(SpriteTypes::SPRITEID_FlameThrower);
				heading = direction_from_index(16 * ((direction_index(u->heading) + 8) / 16 & 15));
			}
			else {
				sprite = get_sprite_type(SpriteTypes::SPRITEID_Bunker_Overlay);
				heading = direction_from_index(16 * 2 * index);
			}
			xy offset = get_image_lo_offset(u->connected_unit->sprite->main_image, 0, index);
			auto* t = create_thingy(sprite, u->sprite->position + offset, 0);
			if (t) {
				t->sprite->elevation_level = u->sprite->elevation_level + 1;
				if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
				// TODO: Image heading/direction
			}
		}

		bool try_attack_something(unit_t* u) {
			if (u->order_target.unit) attack_unit_reacquire_target(u);
			if (!u->order_target.unit) return false;
			if (!unit_can_see_target(u, u->order_target.unit)) return false;
			unit_t* target = u->order_target.unit;
			if (!unit_can_attack_target(u, target)) return false;
			u->order_target.pos = target->sprite->position;
			if (unit_turret(u)) return true;

			const weapon_type_t* weapon;
			int cooldown;
			int anim;
			if (target && u_flying(target)) {
				weapon = unit_air_weapon(u);
				cooldown = u->air_weapon_cooldown;
				anim = iscript_anims::AirAttkRpt;
			}
			else {
				weapon = unit_ground_weapon(u);
				cooldown = u->ground_weapon_cooldown;
				anim = iscript_anims::GndAttkRpt;
			}
			if (!weapon) return false;
			if (cooldown != 0) {
				if (u->order_process_timer > cooldown - 1) u->order_process_timer = cooldown - 1;
				return true;
			}

			if (u_movement_flag(u, 8)) return true;
			int distance = units_distance(unit_main_unit(u), target);
			if (weapon->min_range && distance < weapon->min_range) return false;
			if (distance > weapon_max_range(u, weapon)) return false;

			auto heading_error = fp8::extend(u->heading - xy_direction(target->sprite->position - u->sprite->position)).abs();
			if (heading_error > weapon->attack_angle) {
				if (u_can_turn(u)) {
					u->order_process_timer = 0;
					return true;
				}
				return false;
			}

			if (u_cannot_attack(u)) return false;
			if (u_in_bunker(u)) {
				create_bunker_fire_animation(u);
			}

			u_set_movement_flag(u, 8);
			cooldown = get_modified_weapon_cooldown(u, weapon) + (lcg_rand(12) & 3) - 1;
			u->ground_weapon_cooldown = cooldown;
			u->air_weapon_cooldown = cooldown;
			sprite_run_anim(u->sprite, anim);
			return true;
		}

		unit_t* find_acquire_random_target(const unit_t* u) {
			int acq_range = unit_target_acquisition_range(u);
			if (u_in_bunker(u)) acq_range += 2;

			int min_distance = 0;
			int max_distance = acq_range * 32;

			auto targets = get_default_priority_targets(u, min_distance, max_distance);
			for (auto& v : targets) {
				if (v.empty()) continue;
				if (v.size() == 1) return v.front();
				size_t index = lcg_rand(19) % v.size();
				return v[index];
			}
			return nullptr;
		}

		void order_HoldPosition(unit_t* u) {
			if (u->order_state == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
				if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
				u->order_state = 1;
			}
			if (try_attack_something(u)) {
				unit_t* turret = unit_turret(u);
				if (!turret || unit_is_goliath(u)) {
					set_next_target_waypoint(u, u->order_target.pos);
				}
			}
			else {
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					unit_t* target = find_acquire_random_target(u);
					u->order_target.unit = target;
					if (target) u->order_process_timer = 0;
				}
			}
		}

		bool unit_position_is_visible(const unit_t* u, xy position) const {
			return (st.tiles[tile_index(position)].visible & (1 << u->owner)) == 0;
		}

		const order_type_t* get_default_gather_order(const unit_t* u, const unit_t* target) const {
			if (ut_flag(target, (unit_type_t::flags_t)0x800)) return get_order_type(Orders::Move);
			if (unit_is_mineral_field(target)) {
				if ((u->carrying_flags & ~3) == 0) return get_order_type(Orders::MoveToMinerals);
				else return get_order_type(Orders::Move);
			}
			else if (unit_can_gather_gas(u, target) || unit_is(target, UnitTypes::Resource_Vespene_Geyser)) {
				if ((u->carrying_flags & ~3) == 0) return get_order_type(Orders::MoveToGas);
				else return get_order_type(Orders::Move);
			}
			else if (unit_is_active_resource_depot(target) && target->owner == u->owner) {
				if (u->carrying_flags & 2) return get_order_type(Orders::ReturnMinerals);
				else if (u->carrying_flags & 1) return get_order_type(Orders::ReturnGas);
				else return nullptr;
			}
			else return nullptr;
		}

		const order_type_t* get_default_order(size_t action, const unit_t* u, xy pos, const unit_t* target, const unit_type_t* target_unit_type) const {
			const order_type_t* order;
			switch (action) {
			case 0:
				return nullptr;
			case 1:
				if (u_grounded_building(u)) return nullptr;
				else if (target) {
					if (unit_is_special_beacon(target) || ut_powerup(target)) return get_order_type(Orders::Move);
					else if (unit_target_is_enemy(u, target)) return get_order_type(Orders::AttackDefault);
					else if (unit_provides_space(target) && unit_can_load_target(target, u)) return get_order_type(Orders::EnterTransport);
					else if (u_burrowed(target)) return get_order_type(Orders::Move);
					else return get_order_type(Orders::Follow);
				}
				else {
					if (target_unit_type) return get_order_type(Orders::RightClickAction);
					else return get_order_type(Orders::Move);
				}
			case 2:
				if (!u_grounded_building(u) && target) {
					if (unit_provides_space(u) && unit_can_load_target(u, target)) return get_order_type(Orders::PickupTransport);
					else if (unit_provides_space(target) && unit_can_load_target(target, u)) return get_order_type(Orders::EnterTransport);
					else if (u_burrowed(target)) return get_order_type(Orders::Move);
					else if (unit_is_queen(u) && !u_invincible(target) && unit_can_be_infested(target)) return get_order_type(Orders::CastInfestation);
					else if (unit_is(u, UnitTypes::Terran_Medic)) return get_order_type(Orders::HealMove);
					else return get_order_type(Orders::Follow);
				}
				else {
					if (unit_is_queen(u) && target_unit_type) return get_order_type(Orders::RightClickAction);
					else return get_order_type(Orders::Move);
				}
			case 3:
				if (!target || unit_is_special_beacon(target) || ut_powerup(target)) return u->unit_type->return_to_idle;
				else if (unit_target_is_enemy(u, target)) return get_order_type(Orders::AttackDefault);
				else return u->unit_type->return_to_idle;
			case 4:
				if (auto* o = target ? get_default_gather_order(u, target) : nullptr) return o;
				else return get_default_order(1, u, pos, target, target_unit_type);
			case 5:
				if (!target) return get_default_order(1, u, pos, target, target_unit_type);
				order = get_default_gather_order(u, target);
				if (order) return order;
				if (u_grounded_building(target) && !u_completed(target)) {
					if (target->owner == u->owner && unit_race(target) == race_t::terran) {
						if (!ut_addon(target)) {
							if (!target->connected_unit || target->connected_unit->order_target.unit != target) {
								return get_order_type(Orders::ConstructingBuilding);
							}
						}
					}
				}
				return get_default_order(1, u, pos, target, target_unit_type);
			case 6:
				return nullptr;
			}
			return nullptr;
		}

		size_t default_action(unit_t* u) {
			size_t action = 0;
			if (u->unit_type->id == UnitTypes::Zerg_Lurker && u_burrowed(u)) {
				action = 3;
			}
			else {
				action = u->unit_type->right_click_action;
				if (action == 0 && u_grounded_building(u) && unit_is_factory(u)) {
					action = 2;
				}
			}
			if (u_hallucination(u)) {
				if (action == 4 || action == 5) {
					action = 1;
				}
			}
			return action;
		}

		bool unit_is_door(unit_type_autocast ut) const {
			return ut->id == UnitTypes::Special_Upper_Level_Door || ut->id == UnitTypes::Special_Right_Upper_Level_Door ||
				ut->id == UnitTypes::Special_Pit_Door || ut->id == UnitTypes::Special_Right_Pit_Door;
		}

		bool unit_is_critter(unit_type_autocast ut) const {
			if (unit_is(ut, UnitTypes::Critter_Rhynadon)) return true;
			if (unit_is(ut, UnitTypes::Critter_Bengalaas)) return true;
			if (unit_is(ut, UnitTypes::Critter_Ragnasaur)) return true;
			if (unit_is(ut, UnitTypes::Critter_Scantid)) return true;
			if (unit_is(ut, UnitTypes::Critter_Kakaru)) return true;
			if (unit_is(ut, UnitTypes::Critter_Ursadon)) return true;
			return false;
		}

		bool unit_can_hold_position(const unit_t* u) const {
			if (u->unit_type->right_click_action != 0) return true;
			if (u_grounded_building(u) && unit_is_factory(u)) return true;
			return false;
		}
		bool unit_order_allowed(const unit_t* u, const order_type_t* order) const {
			switch (order->id) {
			case Orders::Die:
				return true;
			case Orders::Stop:
				return true;
			case Orders::Guard:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::PlayerGuard:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::TurretGuard:
				if (!ut_turret(u)) return false;
				return true;
			case Orders::BunkerGuard:
				if (!unit_is(u, UnitTypes::Terran_Bunker)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Move:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::InterceptorAttack:
				if (!unit_is(u, UnitTypes::Protoss_Interceptor)) return false;
				return true;
			case Orders::ScarabAttack:
				if (!unit_is(u, UnitTypes::Protoss_Scarab)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::SpiderMine:
				if (!unit_is(u, UnitTypes::Terran_Vulture_Spider_Mine)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Carrier:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::Reaver:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::ReaverCarrierMove:
				if (!unit_is_carrier(u) && !unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierStop:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::ReaverStop:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierHoldPosition:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::ReaverHoldPosition:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierAttack:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::ReaverAttack:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierMoveToAttack:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::ReaverMoveToAttack:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierIgnore2:
				if (!unit_is_carrier(u) && !unit_is_reaver(u)) return false;
				return true;
			case Orders::CarrierFight:
				if (!unit_is_carrier(u)) return false;
				return true;
			case Orders::ReaverFight:
				if (!unit_is_reaver(u)) return false;
				return true;
			case Orders::AttackDefault:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::MoveToAttack:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::AttackUnit:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::AttackFixedRange:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::AttackTile:
				if (u_grounded_building(u)) return false;
				return true;
			case Orders::Hover:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::AttackMove:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::AtkMoveEP:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::StayInRange:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::TowerGuard:
				if (!unit_is(u, UnitTypes::Terran_Missile_Turret) && !unit_is(u, UnitTypes::Zerg_Spore_Colony) && !unit_is(u, UnitTypes::Zerg_Sunken_Colony) && !unit_is(u, UnitTypes::Protoss_Photon_Cannon)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::TowerAttack:
				if (!unit_is(u, UnitTypes::Terran_Missile_Turret) && !unit_is(u, UnitTypes::Zerg_Spore_Colony) && !unit_is(u, UnitTypes::Zerg_Sunken_Colony) && !unit_is(u, UnitTypes::Protoss_Photon_Cannon) && !unit_is_trap_or_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::TurretAttack:
				if (!ut_turret(u)) return false;
				return true;
			case Orders::Nothing:
				return true;
			case Orders::DroneStartBuild:
				if (!unit_is(u, UnitTypes::Zerg_Drone)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::DroneBuild:
				if (!unit_is(u, UnitTypes::Zerg_Drone)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::DroneLand:
				if (!unit_is(u, UnitTypes::Zerg_Drone)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PlaceBuilding:
				if (!unit_is(u, UnitTypes::Terran_SCV)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PlaceProtossBuilding:
				if (!unit_is(u, UnitTypes::Protoss_Probe)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CreateProtossBuilding:
				if (!unit_is(u, UnitTypes::Protoss_Probe)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PlaceAddon:
				if (u_hallucination(u)) return false;
				return true;
			case Orders::RallyPointUnit:
				if (!u_grounded_building(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::RallyPointTile:
				if (!u_grounded_building(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::InfestedCommandCenter:
				if (!unit_is(u, UnitTypes::Terran_Command_Center)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::BuildNydusExit:
				if (!unit_is_nydus(u)) return false;
				if (u->building.nydus.exit) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::QueenHoldPosition:
				if (!unit_is_queen(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CastInfestation:
				if (!unit_is_queen(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MoveToInfest:
				if (!unit_is_queen(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::InfestingCommandCenter:
				if (!unit_is_queen(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::ConstructingBuilding:
				if (!unit_is(u, UnitTypes::Terran_SCV)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Repair:
				if (!unit_is(u, UnitTypes::Terran_SCV)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MoveToRepair:
				if (!unit_is(u, UnitTypes::Terran_SCV)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::ZergBirth:
				if (!unit_is(u, UnitTypes::Zerg_Egg) && !unit_is(u, UnitTypes::Zerg_Cocoon)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Follow:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::InterceptorReturn:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::BuildingLand:
				if (!ut_flying_building(u)) return false;
				if (u_grounded_building(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::BuildingLiftoff:
				if (!ut_flying_building(u)) return false;
				if (!u_grounded_building(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::LiftingOff:
				if (!ut_flying_building(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CTFCOP2:
				if (!unit_is(u, UnitTypes::Special_Zerg_Flag_Beacon) && !unit_is(u, UnitTypes::Special_Terran_Flag_Beacon) && !unit_is(u, UnitTypes::Special_Protoss_Flag_Beacon)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Larva:
				if (!unit_is(u, UnitTypes::Zerg_Larva)) return false;
				return true;
			case Orders::SpawningLarva:
				if (unit_is_hatchery(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Harvest1:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Harvest2:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MoveToGas:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::WaitForGas:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::ReturnGas:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MoveToMinerals:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::WaitForMinerals:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::ReturnMinerals:
				if (!ut_worker(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::EnterTransport:
				return true;
			case Orders::Unload:
				if (!unit_provides_space(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MoveUnload:
				if (!unit_provides_space(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PickupTransport:
				if (!unit_provides_space(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PickupBunker:
				if (!unit_is(u, UnitTypes::Terran_Bunker)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PickupIdle:
				if (!unit_provides_space(u) && !unit_is(u, UnitTypes::Zerg_Overlord)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::PowerupIdle:
				if (!ut_powerup(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::WatchTarget:
				return true;
			case Orders::InitCreepGrowth:
				if (!unit_is(u, UnitTypes::Zerg_Creep_Colony) && !unit_is(u, UnitTypes::Zerg_Hatchery) && !unit_is(u, UnitTypes::Zerg_Lair) && !unit_is(u, UnitTypes::Zerg_Hive)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::StoppingCreepGrowth:
				if (!unit_is(u, UnitTypes::Zerg_Spore_Colony) && !unit_is(u, UnitTypes::Zerg_Sunken_Colony)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::SpreadCreep:
				if (u_hallucination(u)) return false;
				return true;
			case Orders::GuardianAspect:
				if (!unit_is(u, UnitTypes::Zerg_Mutalisk)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::HoldPosition:
				if (!unit_can_hold_position(u)) return false;
				return true;
			case Orders::Patrol:
				if (!unit_can_move(u)) return false;
				return true;
			case Orders::RechargeShieldsBattery:
				if (!unit_is(u, UnitTypes::Protoss_Shield_Battery)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Scanner:
				if (!unit_is(u, UnitTypes::Spell_Scanner_Sweep)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::NukeWait:
				if (!unit_is(u, UnitTypes::Terran_Nuclear_Missile)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::NukeLaunch:
				if (!unit_is(u, UnitTypes::Terran_Nuclear_Missile)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::NukePaint:
				if (!unit_is(u, UnitTypes::Terran_Ghost)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::NukeUnit:
				if (!unit_is(u, UnitTypes::Terran_Nuclear_Missile)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CastNuclearStrike:
				if (!unit_is(u, UnitTypes::Terran_Nuclear_Missile)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::NukeTrack:
				if (!unit_is(u, UnitTypes::Terran_Nuclear_Missile)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::InitializeArbiter:
				if (!unit_is_arbiter(u)) return false;
				return true;
			case Orders::CloakNearbyUnits:
				if (!unit_is_arbiter(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::RightClickAction:
				return true;
			case Orders::SuicideUnit:
				if (!unit_is(u, UnitTypes::Zerg_Infested_Terran)) return false;
				return true;
			case Orders::SuicideLocation:
				if (!unit_is(u, UnitTypes::Zerg_Infested_Terran)) return false;
				return true;
			case Orders::SuicideHoldPosition:
				if (!unit_is(u, UnitTypes::Zerg_Infested_Terran) && !unit_is(u, UnitTypes::Zerg_Scourge)) return false;
				return true;
			case Orders::SelfDestructing:
				if (!unit_is(u, UnitTypes::Protoss_Scarab)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::Critter:
				if (!unit_is_critter(u)) return false;
				return true;
			case Orders::HiddenGun:
				if (!unit_is_trap_or_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::OpenDoor:
				if (!unit_is_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CloseDoor:
				if (!unit_is_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::HideTrap:
				if (!unit_is_trap_or_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::RevealTrap:
				if (!unit_is_trap_or_door(u)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MedicIdle:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MedicHeal:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::HealMove:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::MedicHoldPosition:
				if (!unit_is(u, UnitTypes::Terran_Medic)) return false;
				if (u_hallucination(u)) return false;
				return true;
			case Orders::CastMindControl:
				if (!unit_is(u, UnitTypes::Protoss_Dark_Archon)) return false;
				if (u_hallucination(u)) return false;
				return true;
			default:
				return false;
			}
		}

		bool medic_can_heal_target(const unit_t* u, const unit_t* target) const {
			if (!target || target == u) return false;
			if (!ut_organic(target) || ut_building(target)) return false;
			if (u_flying(target) || u_hallucination(target)) return false;
			if (target->hp >= target->unit_type->hitpoints) return false;
			if (unit_target_is_enemy(u, target)) return false;
			if (u->owner >= 8 || target->owner >= 8) return false;
			if (unit_is_disabled(target)) return false;
			return true;
		}

		unit_t* find_medic_target(const unit_t* u) const {
			if (!unit_can_use_tech(u, get_tech_type(TechTypes::Healing))) return nullptr;
			return find_nearest_unit(u, square_at(u->sprite->position, 160), [&](unit_t* target) {
				if (target->is_being_healed) return false;
				return medic_can_heal_target(u, target);
				});
		}

		bool unit_can_receive_order(const unit_t* u, const order_type_t* order, int owner) const {
			if (u->owner != owner) return false;
			if (order->id != Orders::RallyPointUnit && order->id != Orders::RallyPointTile) {
				if (!u_completed(u)) return false;
			}
			if (unit_is_disabled(u)) return false;
			if (!unit_is(u, UnitTypes::Zerg_Lurker) && u_burrowed(u)) {
				if (order->id != Orders::Unburrowing) return false;
			}
			if (unit_is(u, UnitTypes::Terran_SCV) && u->order_type->id == Orders::ConstructingBuilding && order->id != Orders::Stop) return false;
			if (unit_is_ghost(u) && u->order_type->id == Orders::NukeTrack) return false;
			if (unit_is(u, UnitTypes::Protoss_Archon) || unit_is(u, UnitTypes::Protoss_Dark_Archon)) {
				if (u->order_type->id == Orders::CompletingArchonSummon) return false;
			}
			return unit_order_allowed(u, order);
		}

		void order_RightClickAction(unit_t* u) {
			if (u->order_state == 0) {
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_position_is_visible(u, u->order_target.pos)) {
					const unit_type_t* target_unit_type = u->order_unit_type;
					xy pos = u->order_target.pos;
					unit_t* target = find_unit_noexpand({ pos - xy(96, 96), pos + xy(96, 96) }, [&](unit_t* n) {
						if (n->unit_type != target_unit_type) return false;
						if (n->sprite->position.x + n->unit_type->placement_size.x / 2 - (unsigned)pos.x >= (unsigned)n->unit_type->placement_size.x) return false;
						if (n->sprite->position.y + n->unit_type->placement_size.y / 2 - (unsigned)pos.y >= (unsigned)n->unit_type->placement_size.y) return false;
						return true;
						});
					const order_type_t* order = get_default_order(default_action(u), u, pos, target, nullptr);
					if (!order) {
						stop_unit(u);
						set_next_target_waypoint(u, u->move_target.pos);
						order_done(u);
					}
					else {
						if (order->id == Orders::AttackDefault) order = u->unit_type->attack_unit;
						if (unit_can_receive_order(u, order, u->owner)) {
							if (target) {
								queue_order_front(u, order, { target->sprite->position, target });
								order_done(u);
							}
							else {
								queue_order_front(u, order, pos);
								order_done(u);
							}
						}
					}
				}
			}
		}

		void order_Patrol(unit_t* u) {
			if (u->order_state == 0) {
				if (u->order_queue.empty() || u->order_queue.front().order_type->id != Orders::Patrol) {
					set_queued_order(u, true, get_order_type(Orders::Patrol), { u->order_target.pos, u->order_target.unit });
					activate_next_order(u);
					queue_order_back(u, get_order_type(Orders::Patrol), u->sprite->position);
					return;
				}
			}
			if (attack_move_movement(u, false)) {
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					if (unit_is(u, UnitTypes::Terran_Medic) && !u->order_target.unit) {
						unit_t* target = find_medic_target(u);
						if (target) {
							queue_order_front(u, get_order_type(Orders::Patrol), u->order_target.pos);
							queue_order_front(u, get_order_type(Orders::MedicHeal), { target->sprite->position, target });
							u->auto_target_unit = nullptr;
							order_done(u);
							u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
							if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
							return;
						}
					}
					if (!unit_is_at_move_target(u)) {
						attack_move_acquire_target(u, false);
					}
					else {
						if (u_immovable(u)) {
							queue_order_back(u, get_order_type(Orders::Patrol), u->order_target.pos);
						}
						else {
							queue_order_back(u, get_order_type(Orders::Patrol), u->sprite->position);
						}
						u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
						order_done(u);
					}
				}
			}
		}

		void order_CastScannerSweep(unit_t* u) {
			auto energy_cost = fp8::integer(get_tech_type(TechTypes::Scanner_Sweep)->energy_cost);
			if (u->energy < energy_cost) {
				order_done(u);
				return;
			}
			const unit_type_t* scan_type = get_unit_type(UnitTypes::Spell_Scanner_Sweep);
			xy pos = u->order_target.pos;
			unit_t* scan = create_unit(scan_type, pos, u->owner);
			if (scan) {
				finish_building_unit(scan);
				complete_unit(scan);
				order_done(u);
				u->energy -= energy_cost;
				//play_sound(388, u);
			}
			else {
				order_done(u);
			}
		}

		void order_Scanner(unit_t* u) {
			if (u->order_signal & 4) {
				u->order_signal &= ~4;
				kill_unit(u);
			}
		}

		void order_TowerGuard(unit_t* u) {
			if (unit_is_disabled(u)) return;
			if (u->main_order_timer == 0) {
				u->main_order_timer = 15;
				unit_t* target = find_acquire_random_target(u);
				u->order_target.unit = target;
				if (target) {
					set_unit_order(u, get_order_type(Orders::TowerAttack), target);
					u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
					if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
				}
			}
		}

		void order_TowerAttack(unit_t* u) {
			if (unit_is_disabled(u) || !try_attack_something(u)) {
				order_done(u);
			}
			else {
				set_unit_move_target(u, u->sprite->position);
				set_next_target_waypoint(u, u->order_target.pos);
			}
		}

		bool weapon_can_target_unit(const weapon_type_t* weapon, const unit_t* target, const unit_t* source_unit) const {
			if (!weapon_can_target_unit(weapon, target)) return false;
			if (target && weapon->target_flags & 0x100 && target->owner != source_unit->owner) return false;
			return true;
		}

		bool spell_order_valid(const unit_t* u) const {
			if (u->order_type->targets_enemies) {
				if (iscript_unit->order_type->weapon == WeaponTypes::None) return false;
				return weapon_can_target_unit(get_weapon_type(iscript_unit->order_type->weapon), u->order_target.unit, u);
			}
			switch (u->order_type->tech_type) {
			case TechTypes::None:
				return true;
			case TechTypes::Spider_Mines:
				return (st.tiles[tile_index(u->order_target.pos)].flags & (tile_t::flag_walkable | tile_t::flag_has_creep)) != 0;
			case TechTypes::EMP_Shockwave:
			case TechTypes::Scanner_Sweep:
			case TechTypes::Dark_Swarm:
			case TechTypes::Plague:
			case TechTypes::Ensnare:
			case TechTypes::Psionic_Storm:
			case TechTypes::Recall:
			case TechTypes::Stasis_Field:
			case TechTypes::Disruption_Web:
			case TechTypes::Maelstrom:
				return true;
			default:
				if (!u->order_target.unit || u_invincible(u->order_target.unit)) return false;
				return unit_tech_target_valid(u, get_tech_type(u->order_type->tech_type), u->order_target.unit);
			}
		}

		bool spell_cast_target_movement(unit_t* u, const tech_type_t* tech, int range) {
			unit_t* target = u->order_target.unit;
			if (!target || !spell_order_valid(u)) {
				order_done(u);
				return false;
			}
			if (u->energy < fp8::integer(tech->energy_cost)) {
				order_done(u);
				return false;
			}
			u->order_target.pos = target->sprite->position;
			set_next_target_waypoint(u, target->sprite->position);
			if (unit_can_see_target(u, target)) {
				if (u_movement_flag(u, 2)) {
					if (!u_movement_flag(target, 2) || fp8::extend(target->next_velocity_direction - u->next_velocity_direction).abs() > 32_fp8) {
						range += unit_halt_distance(u).integer_part();
					}
				}
				if (unit_target_in_range(u, target, range)) {
					stop_unit(u);
					return is_facing_next_target_waypoint(u, 5_fp8);
				}
			}
			if (unit_is_at_move_target(u) && u_immovable(u)) {
				stop_unit(u);
				order_done(u);
				return false;
			}
			try_follow_unit(u, target);
			return false;
		}

		void order_CastDefensiveMatrix(unit_t* u) {
			auto* tech = get_tech_type(TechTypes::Defensive_Matrix);
			if (spell_cast_target_movement(u, tech, unit_sight_range(u, true))) {
				u->energy -= fp8::integer(tech->energy_cost);
				unit_t* target = u->order_target.unit;
				target->defensive_matrix_hp = fp8::integer(250);
				target->defensive_matrix_timer = 168;
				create_defensive_matrix_image(target);
				//play_sound(349, u);
				// TODO
				//create_image(get_image_type(ImageTypes::IMAGEID_Science_Vessel_Overlay_Part2), u->sprite, {}, image_order_above);
				order_done(u);
			}
		}

		bool player_position_is_visible(int owner, xy position) const {
			return (tile_visibility(position) & (1 << owner)) != 0;
		}

		bool unit_can_see_order_target(const unit_t* u) const {
			if (u->order_target.unit) return unit_can_see_target(u, u->order_target.unit);
			return player_position_is_visible(u->owner, u->order_target.pos);
		}

		void order_Spell(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (u->order_state == 2) {
				if (u->order_signal & 2) {
					u->order_signal &= ~2;
					order_done(u);
				}
				else {
					if (target) {
						u->order_target.pos = target->sprite->position;
						set_next_target_waypoint(u, target->sprite->position);
					}
				}
				return;
			}
			if (!spell_order_valid(u)) {
				stop_unit(u);
				order_done(u);
				return;
			}
			auto* tech = u->order_type->tech_type == TechTypes::None ? nullptr : get_tech_type(u->order_type->tech_type);
			if (tech && u->energy < fp8::integer(tech->energy_cost)) {
				order_done(u);
				return;
			}
			auto* weapon = get_weapon_type(u->order_type->weapon);
			if (target) u->order_target.pos = target->sprite->position;
			set_next_target_waypoint(u, u->order_target.pos);
			auto is_in_range = [&]() {
				if (!unit_can_see_order_target(u)) return false;
				if (target) {
					int range = weapon_max_range(u, weapon);
					range += unit_target_movement_range(u, target);
					return unit_target_in_range(u, target, range);
				}
				else {
					int range = weapon_max_range(u, weapon);
					range += unit_halt_distance(u).integer_part();
					return xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= range;
				}
			};
			if (is_in_range()) {
				if (!u_movement_flag(u, 4)) stop_unit(u);
				if (u->spell_cooldown == 0 && unit_can_fire_weapon(u, weapon) && !u_movement_flag(u, 2) && unit_is_at_move_target(u)) {
					if (tech) u->energy -= fp8::integer(tech->energy_cost);
					u->spell_cooldown = get_modified_weapon_cooldown(u, weapon) + (lcg_rand(49) & 3) - 1;
					u_set_movement_flag(u, 8);
					u->order_signal &= ~2;
					sprite_run_anim(u->sprite, u->order_type->animation);
					u->order_state = 2;
				}
			}
			else {
				if (target) {
					if (u->order_state == 0) move_to_target(u, target);
					else try_follow_unit(u, target);
				}
				else {
					if (u->move_target_timer == 0) {
						set_unit_move_target(u, u->order_target.pos);
					}
				}
				set_next_target_waypoint(u, u->order_target.pos);
				if (unit_is_at_move_target(u) && u_immovable(u)) {
					order_done(u);
					return;
				}
			}
			if (u->order_state == 0) u->order_state = 1;
		}

		void order_MoveToTargetOrder(unit_t* u) {
			if (u->order_state == 0) {
				if (u_can_move(u)) {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
				}
				u->order_state = 1;
			}
			else {
				if (player_position_is_visible(u->owner, u->order_target.pos)) {
					xy pos = u->order_target.pos;
					unit_t* target = find_unit_noexpand({ pos - xy(96, 96), pos + xy(96, 96) }, [&](unit_t* n) {
						if (n->unit_type != u->order_unit_type) return false;
						if (n->sprite->position.x + n->unit_type->placement_size.x / 2 - (unsigned)pos.x >= (unsigned)n->unit_type->placement_size.x) return false;
						if (n->sprite->position.y + n->unit_type->placement_size.y / 2 - (unsigned)pos.y >= (unsigned)n->unit_type->placement_size.y) return false;
						return true;
						});
					if (target) {
						const order_type_t* order = get_order_type(u->order_type->target_order);
						if (order->id == Orders::AttackDefault) {
							order = u->unit_type->attack_unit;
							unit_t* turret = unit_turret(u);
							if (turret) {
								queue_order_front(turret, turret->unit_type->attack_unit, { target->sprite->position, target });
								order_done(turret);
							}
						}
						queue_order_front(u, order, { target->sprite->position, target });
					}
					order_done(u);
				}
			}
		}

		void order_PickupBunker(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (target && unit_can_load_target(u, target)) {
				set_unit_order(target, get_order_type(Orders::EnterTransport), u);
			}
			order_done(u);
		}

		void order_HealMove(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (target) {
				if (medic_can_heal_target(u, target)) {
					set_unit_order(u, get_order_type(Orders::MedicHeal), target);
					move_to_target(u, target);
					return;
				}
				u->order_target.pos = target->sprite->position;
			}
			if (u->move_target_timer == 0) {
				set_unit_move_target(u, u->order_target.pos);
			}
			if (unit_is_at_move_target(u)) {
				order_done(u);
				return;
			}
			if (u->main_order_timer == 0) {
				u->main_order_timer = 15;
				unit_t* heal_target = find_medic_target(u);
				if (heal_target) {
					auto prev_target_pos = u->order_target.pos;
					set_unit_order(u, get_order_type(Orders::MedicHeal), heal_target);
					move_to_target(u, heal_target);
					if (target) queue_order_back(u, get_order_type(Orders::HealMove), { target->sprite->position, target });
					else queue_order_back(u, get_order_type(Orders::HealMove), prev_target_pos);
				}
			}
		}

		int medic_try_heal(unit_t* u) {
			if (!unit_can_use_tech(u, get_tech_type(TechTypes::Healing))) return 0;
			unit_t* target = u->order_target.unit;
			if (!target || !medic_can_heal_target(u, target)) return 0;
			if (target->is_being_healed) {
				target = find_medic_target(u);
				if (!target) return 0;
				u->order_target.unit = target;
				u->order_target.pos = target->sprite->position;
				move_to_target(u, target);
			}
			if (!unit_target_in_range(u, target, 30)) return 3;
			fp8 heal_amount = target->unit_type->hitpoints - target->hp;
			if (heal_amount > 200_fp8) heal_amount = 200_fp8;
			fp8 energy_required = heal_amount / 2;
			if (u->energy < energy_required) return 2;
			u->energy -= energy_required;
			set_unit_hp(target, target->hp + heal_amount);
			target->is_being_healed = true;
			return 1;
		}

		void order_MedicHeal(unit_t* u) {
			int r = medic_try_heal(u);
			if (r == 0) {
				stop_unit(u);
				order_done(u);
				return;
			}
			unit_t* target = u->order_target.unit;
			if (u->order_state == 0) {
				if (target && try_follow_unit(u, target) && (!unit_is_at_move_target(u) || !u_immovable(u))) {
					if (unit_target_in_range(u, target, 30)) {
						stop_unit(u);
						u->order_state = 1;
					}
				}
				else {
					order_done(u);
				}
			}
			else {
				if (r == 1) {
					if (~u->order_signal & 1) {
						sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
						if (u->order_queue.empty() || u->order_queue.front().order_type->id != Orders::MedicHealToIdle) {
							queue_order_front(u, get_order_type(Orders::MedicHealToIdle), {});
						}
					}
					set_next_target_waypoint(u, target->sprite->position);
				}
				else {
					u->order_state = 0;
				}
			}
		}

		void order_MedicHealToIdle(unit_t* u) {
			if (~u->movement_flags & 2) {
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
			}
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_MedicIdle(unit_t* u) {
			unit_t* target = find_medic_target(u);
			if (target) {
				set_unit_order(u, get_order_type(Orders::MedicHeal), target);
				move_to_target(u, target);
			}
		}

		void order_MedicHoldPosition(unit_t* u) {
			if (u->order_state == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
				if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
				u->order_state = 1;
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
			}
			int r = medic_try_heal(u);
			if (r == 1) {
				if (~u->order_signal & 1) {
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					if (u->order_queue.empty() || u->order_queue.front().order_type->id != Orders::MedicHealToIdle) {
						queue_order_front(u, get_order_type(Orders::MedicHealToIdle), {});
					}
				}
				set_next_target_waypoint(u, u->order_target.unit->sprite->position);
			}
			else {
				if (r == 3) u->order_target.unit = nullptr;
				sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					unit_t* target = find_medic_target(u);
					u->order_target.unit = target;
					if (target) u->order_target.pos = target->sprite->position;
				}
			}
		}

		void order_NukeTrain(unit_t* u) {
			if (u->order_state == 0) {
				if (u->current_build_unit) {
					u->building.silo.nuke = u->current_build_unit;
					u->current_build_unit->connected_unit = u;
					u->order_state = 1;
				}
			}
			else {
				if (u->building.silo.nuke) {
					if (u_completed(u->building.silo.nuke)) {
						u->building.silo.ready = true;
						u->order_state = 0;
					}
				}
				else u->order_state = 0;
			}
		}

		void order_NukePaint(unit_t* u) {
			if (u->order_target.unit) set_unit_order(u, get_order_type(Orders::NukeUnit), u);
			else set_unit_order(u, get_order_type(Orders::CastNuclearStrike), u->order_target.pos);
		}

		void order_NukeUnit(unit_t* u) {
			if (!u->order_target.unit) {
				stop_unit(u);
				order_done(u);
				return;
			}
			u->order_target.pos = u->order_target.unit->sprite->position;
			order_CastNuclearStrike(u);
		}

		void order_CastNuclearStrike(unit_t* u) {
			set_next_target_waypoint(u, u->order_target.pos);
			if (xy_length(u->exact_position - to_xy_fp8(u->order_target.pos)).integer_part() > unit_sight_range(u)) {
				if (u->move_target_timer == 0) set_unit_move_target(u, u->order_target.pos);
				return;
			}
			stop_unit(u);
			if (!is_facing_next_target_waypoint(u, 1_fp8)) return;
			unit_t* silo = nullptr;
			for (unit_t* n : ptr(st.player_units[u->owner])) {
				if (unit_is(n, UnitTypes::Terran_Nuclear_Silo) && n->building.silo.nuke && n->building.silo.ready) {
					silo = n;
					break;
				}
			}
			if (!silo) {
				order_done(u);
				return;
			}
			//play_sound(239, u);
			unit_t* nuke = silo->building.silo.nuke;
			silo->building.silo.nuke = nullptr;
			silo->building.silo.ready = false;
			set_unit_order(nuke, get_order_type(Orders::NukeLaunch), u->order_target.pos);
			nuke->connected_unit = u;
			// TODO: Set nuke direction facing north
			//set_sprite_images_heading_by_index(nuke->sprite, 0);
			show_unit(nuke);
			u->connected_unit = nuke;
			set_unit_order(u, get_order_type(Orders::NukeTrack), u->sprite->position);
		}

		void order_NukeLaunch(unit_t* u) {
			if (!u->connected_unit && u->order_state < 5) {
				kill_unit(u);
				return;
			}
			if (u->order_state == 0) {
				//play_sound(84, u);
				xy target_pos{ u->sprite->position.x, u->unit_type->dimensions.from.y };
				set_unit_move_target(u, target_pos);
				set_next_target_waypoint(u, target_pos);
				u->main_order_timer = 90;
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (u->main_order_timer <= 45 || unit_is_at_move_target(u)) {
					//play_sound(127, true);
					// todo: callback for message
					u->order_state = 2;
				}
			}
			else if (u->order_state == 2) {
				if (u->main_order_timer == 0 || unit_is_at_move_target(u)) {
					hide_unit(u);
					u->connected_unit->connected_unit = u;
					stop_unit(u);
					u->order_state = 3;
				}
			}
			else if (u->order_state == 3) {
				if (~u->movement_flags & 2) {
					sprite_run_anim(u->sprite, iscript_anims::WarpIn);
					u->order_state = 4;
				}
			}
			else if (u->order_state == 4) {
				if (u->order_signal & 2) {
					u->order_signal &= ~2;
					xy appear_at_pos;
					appear_at_pos.x = std::max(u->unit_type->dimensions.from.x, u->order_target.pos.x);
					appear_at_pos.y = std::max(u->unit_type->dimensions.from.y, u->order_target.pos.y - 320);
					move_unit(u, appear_at_pos);
					set_unit_heading(u, 128_dir);
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
					show_unit(u);
					u->order_state = 5;
				}
			}
			else if (u->order_state == 5) {
				if (xy_length(u->exact_position - to_xy_fp8(u->move_target.pos)).integer_part() <= 10) {
					u->order_target.unit = u;
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					u->order_state = 6;
				}
			}
			else if (u->order_state == 6) {
				if (u->order_signal & 1) {
					u->order_signal &= ~1;
					kill_unit(u);
				}
			}
		}

		void order_NukeTrack(unit_t* u) {
			if (u->order_state == 0) {
				sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
				xy pos;
				if (u->connected_unit) pos = u->connected_unit->order_target.pos;
				thingy_t* t = create_thingy(get_sprite_type(SpriteTypes::SPRITEID_Nuke_Target_Dot), pos, u->owner);
				u->ghost.nuke_dot = t;
				if (t) {
					t->sprite->elevation_level = u->sprite->elevation_level + 1;
					if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
				}
				u->order_state = 6;
			}
			else if (u->order_state == 6) {
				if (!u->connected_unit || u->connected_unit->order_state == 5) {
					if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
					sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
					if (u->ghost.nuke_dot) {
						sprite_run_anim(u->ghost.nuke_dot->sprite, iscript_anims::Death);
						u->ghost.nuke_dot = nullptr;
					}
				}
			}
		}

		bool tile_has_creep(xy pos) {
			return (st.tiles[tile_index(pos)].flags & tile_t::flag_has_creep) != 0;
		}

		void order_Larva(unit_t* u) {
			unit_t* hatchery = u->connected_unit;
			if (hatchery && !unit_target_in_range(u, hatchery, 10)) {
				move_to_target(u, hatchery);
				set_next_target_waypoint(u, hatchery->sprite->position);
			}
			if (unit_is_at_move_target(u) || (u->move_target.unit && u->move_target.pos != u->move_target.unit->sprite->position && !tile_has_creep(u->move_target.pos))) {
				if ((!hatchery || u->move_target.unit != hatchery) && !tile_has_creep(u->sprite->position)) {
					kill_unit(u);
					return;
				}
				int rv = lcg_rand(20);
				xy target_pos = u->sprite->position;
				if (rv & 8) target_pos.x += 10;
				else target_pos.x -= 10;
				if (rv & 0x80) target_pos.y += 10;
				else target_pos.y -= 10;
				if (tile_has_creep(target_pos)) {
					if (hatchery) {
						auto bb = unit_sprite_inner_bounding_box(hatchery);
						auto is_on_correct_side = [&](xy pos) {
							if (u->order_state == 0) return pos.x <= bb.from.x;
							else if (u->order_state == 1) return pos.y <= bb.from.y;
							else if (u->order_state == 2) return pos.x >= bb.to.x;
							else return pos.y >= bb.to.y;
						};
						if (!is_on_correct_side(target_pos)) {
							if (is_on_correct_side(u->sprite->position)) return;
							if (u->order_state == 0) target_pos = { bb.from.x - 10, hatchery->sprite->position.y };
							else if (u->order_state == 1) target_pos = { hatchery->sprite->position.x, bb.from.y - 10 };
							else if (u->order_state == 2) target_pos = { bb.to.x + 10, hatchery->sprite->position.y };
							else target_pos = { hatchery->sprite->position.x, bb.to.y + 10 };
						}
					}
					set_unit_move_target(u, target_pos);
					set_next_target_waypoint(u, target_pos);
				}
			}
		}

		void order_InitCreepGrowth(unit_t* u) {
			set_secondary_order(u, get_order_type(Orders::SpreadCreep));
			set_unit_order(u, u->unit_type->return_to_idle);
		}

		void order_ZergUnitMorph(unit_t* u) {
			const unit_type_t* unit_type = u->build_queue.front();
			if (u->order_state == 0) {
				const unit_type_t* egg_type = nullptr;
				if (unit_is(u, UnitTypes::Zerg_Larva)) egg_type = get_unit_type(UnitTypes::Zerg_Egg);
				else if (unit_is(u, UnitTypes::Zerg_Hydralisk)) egg_type = get_unit_type(UnitTypes::Zerg_Lurker_Egg);
				else if (unit_is(u, UnitTypes::Zerg_Mutalisk)) egg_type = get_unit_type(UnitTypes::Zerg_Cocoon);
				if (!has_available_supply_for(u->owner, unit_type)) {
					cancel_build_queue(u);
					set_unit_order(u, u->unit_type->return_to_idle);
					return;
				}
				u_unset_status_flag(u, unit_t::status_flag_completed);
				morph_unit(u, egg_type);
				u->remaining_build_time = unit_type->build_time;
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (u->remaining_build_time) {
					--u->remaining_build_time;
				}
				else {
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					u->order_state = 2;
				}
			}
			else if (u->order_state == 2) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					morph_unit(u, unit_type);
					// todo: callback for sound
					u->build_queue.erase(u->build_queue.begin());
					if ((int)(ImageTypes)u->unit_type->construction_animation) {
						set_construction_graphic(u, true);
						sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
						set_unit_order(u, get_order_type(Orders::ZergBirth));
					}
					else {
						finish_building_unit(u);
						complete_unit(u);
					}
				}
			}
		}

		void copy_status_effects(unit_t* to, unit_t* from) {
			to->remove_timer = from->remove_timer;
			to->defensive_matrix_hp = from->defensive_matrix_hp;
			to->defensive_matrix_timer = from->defensive_matrix_timer;
			to->stim_timer = from->stim_timer;
			to->ensnare_timer = from->ensnare_timer;
			to->lockdown_timer = from->lockdown_timer;
			to->irradiate_timer = from->irradiate_timer;
			to->stasis_timer = from->stasis_timer;
			to->plague_timer = from->plague_timer;
			to->storm_timer = from->storm_timer;
			to->irradiated_by = from->irradiated_by;
			to->irradiate_owner = from->irradiate_owner;
			to->parasite_flags = from->parasite_flags;
			to->cycle_counter = from->cycle_counter;
			to->blinded_by = from->blinded_by;
			to->maelstrom_timer = from->maelstrom_timer;
			to->acid_spore_count = from->acid_spore_count;
			to->acid_spore_time = from->acid_spore_time;
			apply_unit_effects(to);
			update_unit_speed(to);
		}

		void order_ZergBirth(unit_t* u) {
			if (~u->order_signal & 4) return;
			u->order_signal &= ~4;
			unit_t* u2 = nullptr;
			if (ut_two_units_in_one_egg(u)) {
				xy a = u->sprite->position + get_image_lo_offset(u->sprite->main_image, 3, 0);
				xy b = u->sprite->position + get_image_lo_offset(u->sprite->main_image, 3, 1);
				move_unit(u, a);
				u2 = create_unit(u->unit_type, b, u->owner);
				if (u2) {
					if (unit_is(u2, UnitTypes::Zerg_Zergling)) set_unit_heading(u2, 144_dir);
					else if (unit_is(u2, UnitTypes::Zerg_Scourge)) set_unit_heading(u2, 16_dir);
					else set_unit_heading(u, 0_dir);
					finish_building_unit(u2);
					complete_unit(u2);
					copy_status_effects(u2, u);
				}
			}
			set_construction_graphic(u, false);
			finish_building_unit(u);
			complete_unit(u);
			xy pos = u->sprite->position;
			if (!ut_two_units_in_one_egg(u) && u->previous_unit_type != get_unit_type(UnitTypes::Zerg_Cocoon)) {
				if (u->unit_type->unknown1 == 0xc1) pos.y -= 7;
				else if (u_flying(u)) pos.y -= 42;
			}
			if (pos != u->sprite->position) move_unit(u, pos);
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_DroneStartBuild(unit_t* u) {
			set_unit_order(u, get_order_type(Orders::DroneLand), u->order_target.pos);
			queue_order_back(u, get_order_type(Orders::DroneBuild), u->order_target.pos);
		}

		void order_DroneLand(unit_t* u) {
			const unit_type_t* build_type = u->build_queue.front();
			if (u->order_state == 0) {
				xy pos = u->order_target.pos - xy(0, 7);
				set_unit_move_target(u, pos);
				set_next_target_waypoint(u, pos);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					bool success = false;
					if (!u_immovable(u)) {
						success = can_place_building(u, u->owner, build_type, u->order_target.pos, true, true);
						if (success && unit_is(build_type, UnitTypes::Zerg_Extractor)) {
							const unit_t* gas = get_building_at_center_position(u->order_target.pos, get_unit_type(UnitTypes::Resource_Vespene_Geyser));
							if (gas && unit_target_in_range(u, gas, 32)) {
								u_unset_status_flag(u, unit_t::status_flag_ground_unit);
								u->sprite->elevation_level = u->unit_type->elevation_level + 1;
								set_queued_order(u, false, get_order_type(Orders::ResetCollision), {});
								set_queued_order(u, false, u->unit_type->return_to_idle, {});
								set_unit_move_target(u, u->order_target.pos);
								set_next_target_waypoint(u, u->order_target.pos);
								u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
								u->order_state = 2;
								return;
							}
						}
					}
					if (success) {
						if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= 128) {
							if (u->sprite->images.back().modifier == 10) {
								u->sprite->images.back().frozen_y_value = get_image_map_position(&u->sprite->images.back()).y;
								u->sprite->images.back().flags |= image_t::flag_y_frozen;
							}
							set_unit_move_target(u, u->order_target.pos);
							set_next_target_waypoint(u, u->order_target.pos);
							u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
							u->order_state = 2;
						}
						else success = false;
					}
					if (!success) {
						// todo: callback for sound
						remove_one_order(u, get_order_type(Orders::DroneBuild));
						set_unit_order(u, u->unit_type->return_to_idle);
					}
				}
			}
			else if (u->order_state == 2) {
				if (unit_is_at_move_target(u)) {
					if (u->sprite->images.back().modifier == 10) {
						u->sprite->images.back().offset.y = 0;
						u->sprite->images.back().flags &= ~image_t::flag_y_frozen;
					}
					if (!u_immovable(u)) {
						if (!u->order_queue.empty() && u->order_queue.front().order_type->id == Orders::DroneBuild) {
							move_unit(u, u->order_target.pos);
						}
						else {
							if (u->sprite->images.back().modifier == 10) u->sprite->images.back().offset.y = 7;
							queue_order_front(u, get_order_type(Orders::ResetCollision), {});
						}
					}
					else {
						// todo: callback for sound
						remove_one_order(u, get_order_type(Orders::DroneBuild));
						if (u->sprite->images.back().modifier == 10) u->sprite->images.back().offset.y = 7;
						queue_order_front(u, get_order_type(Orders::ResetCollision), {});
					}
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
				}
			}
		}

		void add_creep_provider(unit_t* u) {
			// TODO: Factorio rewrite
		}

		void zerg_building_start_construction(unit_t* u) {
			add_creep_provider(u);
			set_construction_graphic(u, true);
			u->hp = u->unit_type->hitpoints / 10;
			if (!u->build_queue.empty()) u->build_queue.erase(u->build_queue.begin());
			set_unit_order(u, get_order_type(Orders::IncompleteMorphing));
		}

		void order_DroneBuild(unit_t* u) {
			const unit_type_t* build_type = u->build_queue.front();
			auto done = [&]() {
				if (u->sprite->images.back().modifier == 10) u->sprite->images.back().offset.y = 7;
				queue_order_front(u, get_order_type(Orders::ResetCollision), {});
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
			};
			if (u->sprite->position != u->order_target.pos) {
				done();
				return;
			}
			if (!can_place_building(u, u->owner, build_type, u->sprite->position, true, true)) {
				// todo: callback for sound
				done();
				return;
			}
			if (!player_has_supply_and_resources_for(u->owner, build_type)) {
				done();
				return;
			}

			unit_t* powerup = ut_worker(u) ? u->worker.powerup : nullptr;
			if (powerup) drop_carried_items(u);
			if (unit_is(build_type, UnitTypes::Zerg_Extractor)) {
				unit_t* build_unit = build_refinery(u, build_type);
				if (build_unit) {
					kill_unit(u);
					zerg_building_start_construction(build_unit);
					// TODO
					//create_image(get_image_type(ImageTypes::IMAGEID_Vespene_Geyser2), build_unit->sprite, {}, image_order_below);
				}
				else {
					done();
				}
			}
			else {
				u_unset_status_flag(u, unit_t::status_flag_completed);
				morph_unit(u, build_type);
				zerg_building_start_construction(u);
			}
			if (powerup && ut_powerup(powerup)) move_unit(powerup, powerup->building.powerup.origin);
		}

		void set_creep_building_tiles(unit_type_autocast unit_type, xy pos) {
			// TODO: Factorio rewrite
		}

		void order_IncompleteMorphing(unit_t* u) {
			const unit_type_t* build_type = u->unit_type;
			if (!u->build_queue.empty()) {
				const unit_type_t* queued_type = u->build_queue.front();
				if (unit_type_is_morphing_building(queued_type)) build_type = queued_type;
			}
			if (u->order_state == 0) {
				if (u->remaining_build_time < build_type->build_time * 3 / 4) ++u->order_state;
			}
			else if (u->order_state == 1) {
				if (unit_is(u, UnitTypes::Zerg_Extractor)) {
					destroy_image_from_to(u, ImageTypes::IMAGEID_Vespene_Geyser2, ImageTypes::IMAGEID_Vespene_Geyser2);
				}
				sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
				++u->order_state;
			}
			else if (u->order_state == 2) {
				if (u->remaining_build_time < build_type->build_time / 2) ++u->order_state;
			}
			else if (u->order_state == 3) {
				sprite_run_anim(u->sprite, iscript_anims::SpecialState2);
				++u->order_state;
			}
			else if (u->order_state == 4) {
				if (u->remaining_build_time == 0) ++u->order_state;
			}
			else if (u->order_state == 5) {
				// todo: callback for sound
				sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);
				++u->order_state;
			}
			else if (u->order_state == 6) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					if (unit_type_is_morphing_building(build_type)) {
						u_set_status_flag(u, unit_t::status_flag_completed);
						u_unset_status_flag(u, unit_t::status_flag_completed);
						auto hp = u->hp;
						morph_unit(u, build_type);
						hp += build_type->hitpoints;
						if (u->previous_unit_type) hp -= u->previous_unit_type->hitpoints;
						if (hp < fp8::integer(1)) hp = fp8::integer(1);
						set_unit_hp(u, hp);
						u->remaining_build_time = 0;
					}
					finish_building_unit(u);
					complete_unit(u);
					add_creep_provider(u);
					sprite_run_anim(u->sprite, iscript_anims::AlmostBuilt);

					set_creep_building_tiles(build_type, u->sprite->position);
				}
				return;
			}
			if (u->remaining_build_time) {
				--u->remaining_build_time;
			}
			if (!unit_type_is_morphing_building(build_type)) {
				set_unit_hp(u, u->hp + u->hp_construction_rate);
			}
		}

		void order_ZergBuildingMorph(unit_t* u) {
			const unit_type_t* build_type = u->build_queue.front();
			if (!player_has_supply_and_resources_for(u->owner, build_type)) {
				set_queued_order(u, false, u->unit_type->return_to_idle, {});
				// shouldn't there be an order_done(u) here?
				return;
			}
			u_unset_status_flag(u, unit_t::status_flag_completed);
			set_construction_graphic(u, true);
			u->remaining_build_time = build_type->build_time;
			sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
			set_unit_order(u, get_order_type(Orders::IncompleteMorphing));
		}

		void order_Burrowing(unit_t* u) {
			if (u->order_state == 0) {
				stop_unit(u);
				u->order_state = 1;
			}
			if (u->order_state == 1) {
				if (u_movement_flag(u, 2)) {
					if (u->next_speed == 0_fp8) set_unit_immovable(u);
				}
				else {
					sprite_run_anim(u->sprite, iscript_anims::WalkingToIdle);
					int dir = 12;
					if (unit_is_defiler(u)) dir = 11;
					if (unit_is(u, UnitTypes::Zerg_Drone)) dir = 13;
					set_next_target_waypoint(u, to_xy(u->exact_position + direction_xy(8_dir * dir, 16)));
					u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				if (is_facing_next_target_waypoint(u)) {
					sprite_run_anim(u->sprite, iscript_anims::Burrow);
					u->order_state = 3;
					//play_sound(16, u);
				}
			}
			if (u->order_state == 3) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					for (image_t* image : ptr(u->sprite->images)) {
						if (image->image_type->always_visible) continue;
						hide_image(image);
					}
					image_t* carry_image = find_image(u->sprite, ImageTypes::IMAGEID_Flag, ImageTypes::IMAGEID_Terran_Gas_Tank_Type2);
					if (!carry_image) carry_image = find_image(u->sprite, ImageTypes::IMAGEID_Uraj, ImageTypes::IMAGEID_Khalis);
					if (carry_image) hide_image(carry_image);
					u_set_status_flag(u, unit_t::status_flag_no_collide);
					set_unit_burrowed(u);
					set_secondary_order(u, get_order_type(Orders::Cloak));
					u->detected_flags = 0x80000000;
					if (u->defensive_matrix_hp != 0_fp8) {
						auto hp = u->defensive_matrix_hp;
						auto time = u->defensive_matrix_timer;
						deal_defensive_matrix_damage(u, hp);
						u->defensive_matrix_hp = hp;
						u->defensive_matrix_timer = time;
					}
					if (u->irradiate_timer) destroy_image_from_to(u, ImageTypes::IMAGEID_Irradiate_Small, ImageTypes::IMAGEID_Irradiate_Large);
					if (u->ensnare_timer) destroy_image_from_to(u, ImageTypes::IMAGEID_Ensnare_Overlay_Small, ImageTypes::IMAGEID_Ensnare_Overlay_Large);
					if (u->plague_timer) destroy_image_from_to(u, ImageTypes::IMAGEID_Plague_Overlay_Small, ImageTypes::IMAGEID_Plague_Overlay_Large);
					set_unit_order(u, get_order_type(Orders::Burrowed));
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
				}
			}
		}

		void order_Burrowed(unit_t* u) {
			if (unit_is(u, UnitTypes::Zerg_Lurker)) {
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
			}
			else if (unit_is(u, UnitTypes::Zerg_Hydralisk) && !u->order_queue.empty() && u->order_queue.front().order_type->id == Orders::ZergUnitMorph) {
				set_unit_order(u, get_order_type(Orders::Unburrowing));
				queue_order(std::next(u->order_queue.begin()), u, get_order_type(Orders::ZergUnitMorph), {});
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
			}
		}

		void order_AttackFixedRange(unit_t* u) {
			attack_unit_reacquire_target(u);
			unit_t* target = u->order_target.unit;
			if (target) u->order_target.pos = target->sprite->position;
			if (!unit_can_attack_target(u, target) || !unit_target_in_weapon_movement_range(u, target)) {
				order_done(u);
				return;
			}
			set_next_target_waypoint(u, u->order_target.pos);
			attack_unit_fire_weapon(u);
		}

		void show_image(image_t* image) {
			if (~image->flags & image_t::flag_hidden) return;
			image->flags &= ~image_t::flag_hidden;
			image->flags |= image_t::flag_redraw;
		}

		void order_Unburrowing(unit_t* u) {
			if (u->order_state == 0) {
				u->sprite->elevation_level = u->unit_type->elevation_level;
				u_unset_status_flag(u, unit_t::status_flag_no_collide);
				check_unit_collision(u);
				u->sprite->flags &= sprite_t::flag_hidden;
				set_secondary_order(u, get_order_type(Orders::Nothing));
				sprite_run_anim(u->sprite, iscript_anims::UnBurrow);
				//play_sound(17, u);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				u->detected_flags = 0x80000000;
				u->secondary_order_timer = 0;
				u->order_state = 2;
			}
			if (u->order_state == 2) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					reset_movement_state(u);
					u_unset_status_flag(u, unit_t::status_flag_passively_cloaked);
					u_unset_status_flag(u, unit_t::status_flag_burrowed);
					u->sprite->sprite_type = u->unit_type->flingy->sprite;
					apply_unit_effects(u);
					image_t* carry_image = find_image(u->sprite, ImageTypes::IMAGEID_Flag, ImageTypes::IMAGEID_Terran_Gas_Tank_Type2);
					if (!carry_image) carry_image = find_image(u->sprite, ImageTypes::IMAGEID_Uraj, ImageTypes::IMAGEID_Khalis);
					if (carry_image) show_image(carry_image);
					// TODO: Set image heading/direction
					u->order_state = 3;
				}
			}
			else if (u->order_state == 3) {
				if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
			}
		}

		void order_BuildNydusExit(unit_t* u) {
			if (!can_place_building(u, u->owner, get_unit_type(UnitTypes::Zerg_Nydus_Canal), u->order_target.pos, true, false)) {
				order_done(u);
				return;
			}
			unit_t* exit = create_unit(UnitTypes::Zerg_Nydus_Canal, u->order_target.pos, u->owner);
			if (exit) {
				set_construction_graphic(exit, true);
				exit->hp = exit->unit_type->hitpoints / 10;
				set_unit_order(exit, get_order_type(Orders::IncompleteMorphing));
				add_creep_provider(exit);
				if (unit_is_nydus(u)) u->building.nydus.exit = exit;
				if (unit_is_nydus(exit)) exit->building.nydus.exit = u;
				order_done(u);
			}
			else {
				order_done(u);
			}
		}

		void refresh_unit_position(unit_t* u) {
			unit_t* turret = unit_turret(u);
			if (turret) {
				turret->exact_position = u->exact_position;
				turret->position = to_xy(turret->exact_position);
				move_sprite(turret->sprite, turret->position);
			}
			if (us_hidden(u)) {
				u->sprite->flags &= ~sprite_t::flag_hidden;
				if (turret) turret->sprite->flags &= ~sprite_t::flag_hidden;
				st.hidden_units.remove(*u);
				bw_insert_list(st.visible_units, *u);
			}
			update_unit_sprite(u);
			if (u_grounded_building(u)) set_unit_tiles_occupied(u, u->sprite->position);
			check_unit_collision(u);
			if (u_flying(u)) increment_repulse_field(u);
			reset_movement_state(u);
			if (turret) reset_movement_state(turret);
		}

		void order_EnterNydusCanal(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || !unit_can_enter_nydus(u, target)) {
				order_done(u);
				return;
			}
			unit_t* exit = unit_is_nydus(target) ? target->building.nydus.exit : nullptr;
			if (!exit) exit = target;
			if (u->order_state == 0) {
				move_to_target_reset(u, target);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (u_immovable(u)) {
						order_done(u);
					}
					else u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				hide_unit(u);
				auto prev_pos = u->sprite->position;
				move_unit(u, exit->sprite->position);
				bool res;
				xy pos;
				std::tie(res, pos) = find_unit_placement(u, exit->sprite->position, false);
				if (res) {
					//play_sound(19, target);
					move_unit(u, pos);
					refresh_unit_position(u);
					order_done(u);
					//play_sound(19, exit);
				}
				else {
					move_unit(u, prev_pos);
					refresh_unit_position(u);
				}
			}
		}

		void order_CastInfestation(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (u->order_state == 0) {
				if (!target) {
					order_done(u);
					return;
				}
				if (!unit_can_be_infested(target)) {
					// todo: erorr message
					order_done(u);
					return;
				}
				move_to_target_reset(u, target);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (target && unit_can_be_infested(target) && !u_immovable(u)) {
						set_unit_order(u, get_order_type(Orders::InfestingCommandCenter), target);
					}
					else order_done(u);
				}
				else if (target) try_follow_unit(u, target);
			}
		}

		void order_InfestingCommandCenter(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (u->order_state == 0) {
				if (target && unit_can_be_infested(target) && target->order_type->id != Orders::InfestedCommandCenter) {
					hide_unit(u);
					set_unit_order(target, get_order_type(Orders::InfestedCommandCenter), u);
					u->remaining_build_time = 60;
					u->order_state = 3;
				}
				else {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
				}
			}
			else if (u->order_state == 3) {
				if (u->remaining_build_time) {
					--u->remaining_build_time;
					return;
				}
				bool res;
				xy pos;
				std::tie(res, pos) = find_unit_placement(u, u->sprite->position, false);
				if (res) {
					move_unit(u, pos);
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					show_unit(u);
					if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
				}
			}
		}

		unit_t* unit_addon(const unit_t* u) const {
			return ut_building(u) ? u->building.addon : nullptr;
		}

		bool units_share_unions(unit_type_autocast a, unit_type_autocast b) const {
			if (unit_is(a, UnitTypes::Protoss_Interceptor) != unit_is(b, UnitTypes::Protoss_Interceptor)) return false;
			if (unit_is(a, UnitTypes::Protoss_Scarab) != unit_is(b, UnitTypes::Protoss_Scarab)) return false;
			if (unit_is_carrier(a) != unit_is_carrier(b)) return false;
			if (unit_is_reaver(a) != unit_is_reaver(b)) return false;
			if (unit_is_ghost(a) != unit_is_ghost(b)) return false;
			if (ut_resource(a) != ut_resource(b)) return false;
			if (unit_is_nydus(a) != unit_is_nydus(b)) return false;
			if (unit_is(a, UnitTypes::Terran_Nuclear_Silo) != unit_is(b, UnitTypes::Terran_Nuclear_Silo)) return false;
			if (ut_powerup(a) != ut_powerup(b)) return false;
			if (unit_is_hatchery(a) != unit_is_hatchery(b)) return false;
			return true;
		}

		void order_InfestedCommandCenter(unit_t* u) {
			unit_t* queen = u->order_target.unit;
			if (!queen || !unit_can_be_infested(u)) {
				u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
				order_done(u);
				return;
			}
			if (u->order_state == 0) {
				u->remaining_build_time = 3;
				u->order_state = 2;
				return;
			}
			if (u->remaining_build_time) {
				--u->remaining_build_time;
				return;
			}
			u->remaining_build_time = 0xffff;
			if (unit_addon(u)) building_abandon_addon(u);
			const unit_type_t* new_type = u->unit_type->infestation_unit;
			// todo: update scores
			u->unit_type = new_type;
			set_unit_owner(u, queen->owner, true);
			set_sprite_owner(u, queen->owner);
			u->secondary_order_type = nullptr;
			set_secondary_order(u, get_order_type(Orders::Nothing));
			cancel_build_queue(u);
			while (!u->order_queue.empty()) remove_queued_order(u, &u->order_queue.front());
			if (u_grounded_building(u)) sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
			// TODO
			//if (u->unit_type->construction_animation) create_image(u->unit_type->construction_animation, u->sprite, {}, image_order_above);
			set_unit_hp(u, u->unit_type->hitpoints);
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_SuicideUnit(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				order_done(u);
				return;
			}
			if (!unit_can_attack_target(u, target)) {
				set_unit_order(u, get_order_type(Orders::Move), target->sprite->position);
				return;
			}
			if (u->order_state == 0) {
				move_to_target(u, target);
				u->order_state = 1;
			}
			if (u->order_state == 1) {
				if ((unit_is_at_move_target(u) && u_immovable(u)) || unit_target_in_range(u, target, 4)) {
					stop_unit(u);
					if (!unit_target_in_range(u, target, get_weapon_type(WeaponTypes::Suicide_Infested_Terran)->outer_splash_radius)) {
						order_done(u);
						return;
					}
					u->order_target.unit = u;
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
					u->order_state = 2;
				}
				else {
					if (unit_target_in_range(u, target, 256) && u_movement_flag(target, 2)) crappy_move_to_target(u, target);
					else try_follow_unit(u, target);
				}
			}
			if (u->order_state == 2) {
				if (u->order_signal & 1) {
					u_set_status_flag(u, unit_t::status_flag_lifetime_expired);
					kill_unit(u);
				}
			}
		}

		void order_SuicideLocation(unit_t* u) {
			if (u->order_state == 0) {
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
				u->order_state = 1;
			}
			if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (u_immovable(u) && xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() > get_weapon_type(WeaponTypes::Suicide_Infested_Terran)->outer_splash_radius) {
						order_done(u);
						return;
					}
					u->order_target.unit = u;
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					u_set_status_flag(u, unit_t::status_flag_order_not_interruptible);
					u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				if (u->order_signal & 1) {
					u_set_status_flag(u, unit_t::status_flag_lifetime_expired);
					kill_unit(u);
				}
			}
		}

		void order_SuicideHoldPosition(unit_t* u) {
			if (u->order_state == 0) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				u->order_state = 1;
			}
			if (!u->order_queue.empty()) activate_next_order(u);
		}

		void order_QueenHoldPosition(unit_t* u) {
			order_SuicideHoldPosition(u);
		}

		void order_PlaceProtossBuilding(unit_t* u) {
			if (u->order_state == 0) {
				set_unit_move_target(u, u->order_target.pos);
				set_next_target_waypoint(u, u->order_target.pos);
				u->order_state = 1;
			}
			else if (u->order_state == 1 || u->order_state == 2) {
				const unit_type_t* build_type = u->build_queue.front();
				if (u->order_state == 2 && u_movement_flag(u, 2)) return;
				int d = 70;
				if (unit_is(build_type, UnitTypes::Protoss_Assimilator)) d += 18;
				if (xy_length(to_xy_fp8(u->order_target.pos) - u->exact_position).integer_part() <= d) {
					if (u->order_state == 1) {
						stop_unit(u);
						set_next_target_waypoint(u, u->move_target.pos);
						u->order_state = 2;
					}
					else {
						auto can_build = [&]() {
							if (!player_has_supply_and_resources_for(u->owner, build_type)) return false;
							if (!can_place_building(u, u->owner, build_type, u->order_target.pos, true, false)) return false;
							return true;
						};
						if (can_build()) {
							unit_t* build_unit;
							if (build_type->id == UnitTypes::Protoss_Assimilator) build_unit = build_refinery(u, build_type);
							else build_unit = create_unit(build_type, u->order_target.pos, u->owner);
							u->build_queue.erase(u->build_queue.begin());
							// TODO: Factorio handled
							order_done(u);
						}
						else {
							order_done(u);
						}
					}
				}
				else {
					if (unit_is_at_move_target(u)) {
						set_unit_move_target(u, u->order_target.pos);
						set_next_target_waypoint(u, u->order_target.pos);
					}
				}
			}
		}

		void set_unit_shield_points(unit_t* u, fp8 shield_points) {
			u->shield_points = std::min(shield_points, fp8::integer(u->unit_type->shield_points));
		}

		void order_InitializeArbiter(unit_t* u) {
			if (u->order_queue.empty()) {
				set_unit_order(u, get_unit_type(UnitTypes::Protoss_Arbiter)->return_to_idle);
			}
			if (!u_hallucination(u)) {
				set_secondary_order(u, get_order_type(Orders::CloakNearbyUnits));
			}
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void merge_status_effects(unit_t* to, unit_t* from) {
			to->defensive_matrix_hp = std::max(to->defensive_matrix_hp, from->defensive_matrix_hp);
			to->defensive_matrix_timer = std::max(to->defensive_matrix_timer, from->defensive_matrix_timer);
			to->stim_timer = std::max(to->stim_timer, from->stim_timer);
			to->ensnare_timer = std::max(to->ensnare_timer, from->ensnare_timer);
			to->lockdown_timer = std::max(to->lockdown_timer, from->lockdown_timer);
			to->stasis_timer = std::max(to->stasis_timer, from->stasis_timer);
			to->plague_timer = std::max(to->plague_timer, from->plague_timer);
			if (from->irradiate_timer > to->irradiate_timer) {
				to->irradiate_timer = from->irradiate_timer;
				to->irradiated_by = from->irradiated_by;
				to->irradiate_owner = from->irradiate_owner;
			}
			to->parasite_flags |= from->parasite_flags;
			to->blinded_by |= from->blinded_by;
			to->maelstrom_timer = std::max(from->maelstrom_timer, to->maelstrom_timer);
			to->acid_spore_count = from->acid_spore_count;
			to->acid_spore_time = from->acid_spore_time;
		}

		void decloak_unit(unit_t* u) {
			if (u_burrowed(u)) {
				u_unset_status_flag(u, unit_t::status_flag_requires_detector);
				u_unset_status_flag(u, unit_t::status_flag_cloaked);
				for (image_t* image : ptr(u->sprite->images)) {
					if (!image->image_type->always_visible) show_image(image);
					if (image->modifier >= 2 && image->modifier <= 7) {
						set_image_modifier(image, 0);
					}
				}
			}
			else {
				//play_sound(274, u);
				auto decloak = [&](unit_t* u) {
					u_unset_status_flag(u, unit_t::status_flag_requires_detector);
					u_set_status_flag(u, unit_t::status_flag_cloaked);
					for (image_t* image : ptr(u->sprite->images)) {
						show_image(image);
						if (image->modifier == 2 || image->modifier == 3) {
							set_image_modifier(image, 4);
							image->modifier_data1 = 8;
							image->modifier_data2 = 3;
						}
						else if (image->modifier == 5 || image->modifier == 6) {
							set_image_modifier(image, 7);
							image->modifier_data1 = 8;
							image->modifier_data2 = 3;
						}
					}
				};
				decloak(u);
				if (u->subunit) decloak(u->subunit);
			}
		}

		void order_ArchonWarp(unit_t* u) {
			bool is_dark_archon = u->order_type->id == Orders::DarkArchonMeld;
			unit_t* target = u->order_target.unit;
			if (!target || target->owner != u->owner || target->order_type != u->order_type || target->order_target.unit != u) {
				stop_unit(u);
				set_next_target_waypoint(u, u->move_target.pos);
				order_done(u);
				return;
			}
			if (u_ground_unit(u)) {
				if (unit_target_in_range(u, target, (u->next_speed * 2).integer_part())) {
					u_unset_status_flag(u, unit_t::status_flag_ground_unit);
					queue_order_front(u, get_order_type(Orders::ResetCollision), {});
				}
			}
			int d = xy_length(u->sprite->position - target->sprite->position);
			if (d <= (is_dark_archon ? 20 : 2)) {
				merge_status_effects(u, target);
				morph_unit(u, get_unit_type(is_dark_archon ? UnitTypes::Protoss_Dark_Archon : UnitTypes::Protoss_Archon));
				if (is_dark_archon) decloak_unit(u);
				u->sprite->flags &= ~sprite_t::flag_iscript_nobrk;
				sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
				if (is_dark_archon) u->energy = fp8::integer(50);
				kill_unit(target);
				u_unset_status_flag(u, unit_t::status_flag_can_move);
				reset_movement_state(u);
				set_unit_order(u, get_order_type(Orders::CompletingArchonSummon));
			}
			else {
				if (u->order_state && unit_is_at_move_target(u) && u_immovable(u)) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					order_done(u);
				}
				else {
					u->order_state = 1;
					if (u->move_target_timer == 0) {
						if (d <= (is_dark_archon ? 19 : 10)) {
							set_unit_move_target(u, (u->sprite->position + target->sprite->position) / 2);
						}
						else {
							set_unit_move_target(u, target->sprite->position);
						}
					}
				}
			}
		}

		void order_CompletingArchonSummon(unit_t* u) {
			if (u->order_state == 0) {
				if (u->remaining_build_time) {
					--u->remaining_build_time;
				}
				else {
					u->sprite->flags &= ~sprite_t::flag_iscript_nobrk;
					sprite_run_anim(u->sprite, iscript_anims::Init);
					u->order_state = 1;
				}
			}
			else if (u->order_state == 1) {
				if (u->order_signal & 4) {
					u->order_signal &= ~4;
					u_set_status_flag(u, unit_t::status_flag_can_move);
					reset_movement_state(u);
					// todo: callback for sound
					set_queued_order(u, false, u->unit_type->human_ai_idle, {});
					u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
					order_done(u);
				}
			}
		}

		void order_CastRecall(unit_t* u) {
			if (u->order_state == 0) {
				if (u->energy < fp8::integer(get_tech_type(TechTypes::Recall)->energy_cost)) {
					order_done(u);
					return;
				}
				u->energy -= fp8::integer(get_tech_type(TechTypes::Recall)->energy_cost);
				if (u->order_target.unit) u->order_target.pos = u->order_target.unit->sprite->position;
				thingy_t* t = create_thingy(get_sprite_type(SpriteTypes::SPRITEID_Recall_Field), u->order_target.pos, 0);
				if (t) {
					t->sprite->elevation_level = u->sprite->elevation_level + 1;
					if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
				}
				//play_sound(550 + lcg_rand(17) % 2, u->order_target.pos);
				u->main_order_timer = 22;
				u->order_state = 1;
			}
			else if (u->order_state == 1 && u->main_order_timer == 0) {
				int n_recalled = 0;
				std::vector<unit_t*> targets;
				for (unit_t* target : find_units_noexpand(square_at(u->order_target.pos, 64))) {
					if (target == u) continue;
					if (target->owner != u->owner) continue;
					if (us_hidden(target)) continue;
					if (ut_building(target)) continue;
					if (u_invincible(target)) continue;
					if (u_hallucination(target)) continue;
					if (u_burrowed(target)) continue;
					if (unit_is(target, UnitTypes::Zerg_Larva)) continue;
					if (unit_is(target, UnitTypes::Zerg_Egg)) continue;
					if (unit_is(target, UnitTypes::Zerg_Lurker_Egg)) continue;

					targets.push_back(target);
				}
				for (unit_t* target : targets) {

					xy target_pos = target->sprite->position;
					move_unit(target, u->sprite->position);
					auto r = find_unit_placement(target, u->sprite->position, false);
					if (!r.first) {
						move_unit(target, target_pos);
						continue;
					}

					for (unit_t* n : ptr(st.visible_units)) {
						remove_target_references(n, target);
					}
					for (bullet_t* n : ptr(st.active_bullets)) {
						remove_target_references(n, target);
					}
					if (u_grounded_building(target)) set_unit_tiles_unoccupied(target, target->sprite->position);
					if (u_flying(target)) decrement_repulse_field(target);
					reset_movement_state(target);

					move_unit(target, r.second);
					refresh_unit_position(target);
					if (!unit_is(target, UnitTypes::Zerg_Cocoon)) set_unit_order(target, target->unit_type->return_to_idle);
					thingy_t* t = create_thingy(get_sprite_type(SpriteTypes::SPRITEID_Recall_Field), r.second, 0);
					if (t) {
						t->sprite->elevation_level = target->sprite->elevation_level + 1;
						if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
					}
					if (unit_is_ghost(target) && target->connected_unit && unit_is(target->connected_unit, UnitTypes::Terran_Nuclear_Missile)) {
						target->connected_unit->connected_unit = nullptr;
						target->connected_unit = nullptr;
					}
					++n_recalled;
				}
				if (n_recalled) {
					//play_sound(552 + lcg_rand(18) % 2, u);
				}
				order_done(u);
			}
		}

		void interceptors_attack(unit_t* u) {
			if (!unit_is_carrier(u)) return;
			for (unit_t* n : ptr(u->carrier.outside_units)) {
				n->sprite->elevation_level = u->sprite->elevation_level - 1;
				set_unit_order(n, n->unit_type->attack_unit, u->order_target.unit);
			}
		}

		bool carrier_reaver_attack(unit_t* u, int acquire_range, int max_ground_distance) {
			bool can_move = u->order_type->id != Orders::CarrierHoldPosition && u->order_type->id != Orders::ReaverHoldPosition;
			if (!can_move && u_movement_flag(u, 2)) stop_unit(u);
			unit_t* target = u->order_target.unit;
			auto can_attack_target = [&]() {
				if (unit_can_see_target(u, target) && unit_target_in_range(u, target, acquire_range + unit_target_movement_range(u, target))) {
					if (max_ground_distance == 0 || unit_long_path_distance(u, u->sprite->position, u->order_target.pos) < max_ground_distance) {
						return true;
					}
				}
				return false;
			};
			if (target) {
				if (u_invincible(target) || !unit_can_attack_target(u, target)) {
					if (u->auto_target_unit == target) u->auto_target_unit = nullptr;
					u->order_target.unit = nullptr;
				}
				else {
					u->order_target.pos = target->sprite->position;
					if (can_attack_target()) {
						stop_unit(u);
					}
					else {
						if (!can_move || u_ready_to_attack(u)) {
							if (u->auto_target_unit == target) u->auto_target_unit = nullptr;
							u->order_target.unit = nullptr;
							return false;
						}
						set_unit_move_target(u, u->order_target.pos);
						set_next_target_waypoint(u, u->order_target.pos);
					}
				}
			}
			if (unit_interceptor_count(u) == 0 && (!unit_is_reaver(u) || u->reaver.inside_count + u->reaver.outside_count == 0)) {
				stop_unit(u);
				order_done(u);
				return false;
			}
			if (u->main_order_timer) return false;
			target = u->order_target.unit;
			if (!target) {
				if (!u->order_queue.empty()) {
					activate_next_order(u);
					return false;
				}
			}
			if (!target || u_ready_to_attack(u)) {
				attack_unit_reacquire_target(u);
				if (unit_is_carrier(u) && u->order_target.unit != target) interceptors_attack(u);
				target = u->order_target.unit;
			}
			if (target) {
				if (can_move) {
					if (unit_is_reaver(u)) u->order_type = get_order_type(Orders::ReaverFight);
					else u->order_type = get_order_type(Orders::CarrierFight);
				}
				return can_attack_target();
			}
			else {
				unit_t* new_target = find_acquire_random_target(u);
				if (!new_target) {
					if (can_move && u->order_type->id != Orders::CarrierIgnore2) {
						if (unit_is_reaver(u)) u->order_type = get_order_type(Orders::Reaver);
						else u->order_type = get_order_type(Orders::Carrier);
					}
					return false;
				}
				if (can_move) {
					if (unit_is_reaver(u)) u->order_type = get_order_type(Orders::ReaverFight);
					else u->order_type = get_order_type(Orders::CarrierFight);
				}
				u->order_target.pos = new_target->sprite->position;
				u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
				if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
				if (max_ground_distance != 0 && unit_long_path_distance(u, u->sprite->position, u->order_target.pos) >= max_ground_distance) return false;
				u->order_target.unit = new_target;
				return true;
			}
		}

		unit_t* release_fighter(unit_t* u) {
			if (!unit_is_carrier(u) && !unit_is_reaver(u)) return nullptr;
			auto& inside_units = unit_is_reaver(u) ? u->reaver.inside_units : u->carrier.inside_units;
			unit_t* r = nullptr;
			fp8 best_hp;
			for (unit_t* n : ptr(inside_units)) {
				if (!u_completed(n)) continue;
				if (!r || n->hp > best_hp) {
					if (!r) best_hp = n->hp;
					r = n;
				}
			}
			if (!r) return nullptr;
			if (unit_is(r, UnitTypes::Protoss_Interceptor) && r->hp < r->unit_type->hitpoints / 2) return nullptr;
			xy pos = u->position;
			if (unit_is(r, UnitTypes::Protoss_Scarab)) {
				pos += to_xy(direction_xy(u->heading, 25));
				set_unit_heading(r, u->heading);
			}
			inside_units.remove(*r);
			if (unit_is_reaver(u)) {
				--u->reaver.inside_count;
				u->reaver.outside_units.push_front(*r);
				++u->reaver.outside_count;
			}
			else {
				--u->carrier.inside_count;
				u->carrier.outside_units.push_front(*r);
				++u->carrier.outside_count;
			}
			move_unit(r, pos);
			show_unit(r);
			r->fighter.is_outside = true;
			return r;
		}

		void order_Carrier(unit_t* u) {
			if (carrier_reaver_attack(u, 32 * unit_target_acquisition_range(u), 0)) {
				unit_t* fighter = release_fighter(u);
				if (fighter) {
					fighter->shield_points = fp8::integer(fighter->unit_type->shield_points);
					fighter->sprite->elevation_level = u->sprite->elevation_level - 1;
					set_unit_order(fighter, fighter->unit_type->attack_unit, u->order_target.unit);
					u->main_order_timer = 7;
				}
			}
		}

		void order_CarrierStop(unit_t* u) {
			stop_unit(u);
			set_next_target_waypoint(u, u->move_target.pos);
			return_interceptors(u);
			set_unit_order(u, get_order_type(Orders::Carrier), u->order_target.unit);
		}

		void order_CarrierAttack(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				order_done(u);
				return;
			}
			if (!unit_can_attack_target(u, target)) {
				set_unit_order(u, get_order_type(Orders::Move), u->order_target.pos);
				return;
			}
			bool ready_to_attack = u_ready_to_attack(u);
			bool flag_8 = u_status_flag(u, unit_t::status_flag_8);
			interceptors_attack(u);
			queue_order_front(u, get_order_type(Orders::CarrierFight), target);
			activate_next_order(u);
			u_set_status_flag(u, unit_t::status_flag_ready_to_attack, ready_to_attack);
			u_set_status_flag(u, unit_t::status_flag_8, flag_8);
		}

		void order_InterceptorAttack(unit_t* u) {
			unit_t* parent = u->fighter.parent;
			if (parent && u->shield_points < fp8::integer(u->unit_type->shield_points) / 4) {
				set_unit_order(u, get_order_type(Orders::InterceptorReturn));
				return;
			}
			unit_t* target = u->order_target.unit;
			if (!target || u_invincible(target)) {
				if (!unit_autoattack(u)) {
					set_unit_order(u, get_order_type(Orders::InterceptorReturn));
					return;
				}
				target = u->order_target.unit;
			}
			u->order_target.pos = target->sprite->position;
			if (parent) {
				int range = 32 * (unit_target_acquisition_range(parent) + 2);
				if (!unit_target_in_range(parent, target, range + unit_target_movement_range(parent, target))) {
					set_unit_order(u, get_order_type(Orders::InterceptorReturn));
					return;
				}
			}

			auto set_interceptor_move_target = [&](int mult) {
				int x = lcg_rand(11, -127, 128) * mult;
				int y = lcg_rand(11, -127, 128) * mult;
				xy pos = u->order_target.pos + xy(x, y);
				auto dims = u->unit_type->dimensions;
				set_unit_move_target(u, pos);
				set_next_target_waypoint(u, pos);
			};

			if (u->order_state == 0) {
				if (!parent) {
					kill_unit(u);
					return;
				}
				//play_sound(616, u);
				set_interceptor_move_target(3);
				u->main_order_timer = 15;
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (u->main_order_timer == 0) {
					u->sprite->elevation_level += 2;
					u->order_state = 3;
				}
			}
			if (u->order_state == 3) {
				if (unit_target_in_weapon_movement_range(u, target)) attack_unit_fire_weapon(u);
				if (unit_target_in_range(u, target, 50 + unit_target_movement_range(u, target))) {
					set_interceptor_move_target(1);
					u->order_state = 4;
				}
				else {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
				}
			}
			else if (u->order_state == 4) {
				if (xy_length(to_xy_fp8(u->move_target.pos) - u->exact_position).integer_part() <= 50) {
					set_interceptor_move_target(2);
					u->order_state = 5;
				}
			}
			else if (u->order_state == 5) {
				if (xy_length(to_xy_fp8(u->move_target.pos) - u->exact_position).integer_part() <= 50) {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
					u->order_state = 3;
				}
			}
		}

		void order_InterceptorReturn(unit_t* u) {
			unit_t* parent = u->fighter.parent;
			if (!parent) {
				kill_unit(u);
				return;
			}
			if (u->order_state == 0) {
				if (xy_length(to_xy_fp8(parent->sprite->position) - u->exact_position).integer_part() <= 60) {
					u->order_state = 1;
					if (unit_is(u, UnitTypes::Protoss_Interceptor)) u->sprite->elevation_level = parent->sprite->elevation_level - 2;
				}
			}
			if (xy_length(to_xy_fp8(parent->sprite->position) - u->exact_position).integer_part() <= 10) {
				if (unit_is_carrier(parent)) {
					parent->carrier.outside_units.remove(*u);
					--parent->carrier.outside_count;
					parent->carrier.inside_units.push_front(*u);
					++parent->carrier.inside_count;
				}
				else if (unit_is_reaver(parent)) {
					parent->reaver.outside_units.remove(*u);
					--parent->reaver.outside_count;
					parent->reaver.inside_units.push_front(*u);
					++parent->reaver.inside_count;
				}
				u->fighter.is_outside = false;
				hide_unit(u);
				set_unit_order(u, get_order_type(Orders::Nothing));
			}
			else {
				set_unit_move_target(u, parent->sprite->position);
				set_next_target_waypoint(u, parent->sprite->position);
			}
		}

		void order_DarkArchonMeld(unit_t* u) {
			order_ArchonWarp(u);
		}

		bool unit_is_building_addon(const unit_t* u) const {
			if (u->secondary_order_type->id == Orders::BuildAddon) {
				if (u_grounded_building(u) && u->current_build_unit && !u_completed(u->current_build_unit)) return true;
			}
			return false;
		}
		bool trigger_give_unit_to(unit_t* u, int new_owner) {
			if (u_hallucination(u)) return false;
			if (unit_is_mineral_field(u)) return false;
			if (unit_is(u, UnitTypes::Resource_Vespene_Geyser)) return false;
			if (unit_is_fighter(u)) return false;
			if (ut_addon(u)) return false;
			if (u->owner == new_owner) return false;
			if (u_completed(u) && unit_is_refinery(u)) {
				for (unit_t* n : ptr(st.player_units[u->owner])) {
					if (!ut_worker(n)) continue;
					if (!us_hidden(n)) continue;
					if (n->order_type->id != Orders::HarvestGas) continue;
					if (n->order_target.unit != u) continue;
					give_unit_to(n, new_owner);
					break;
				}
			}
			give_unit_to(u, new_owner);
			if (unit_provides_space(u)) {
				for (unit_t* n : loaded_units(u)) {
					give_unit_to(n, new_owner);
				}
			}
			if (unit_is_carrier(u)) {
				for (unit_t* n : ptr(u->carrier.inside_units)) {
					give_unit_to(n, new_owner);
				}
				for (unit_t* n : ptr(u->carrier.outside_units)) {
					give_unit_to(n, new_owner);
				}
			}
			else if (unit_is_reaver(u)) {
				for (unit_t* n : ptr(u->reaver.inside_units)) {
					give_unit_to(n, new_owner);
				}
				for (unit_t* n : ptr(u->reaver.outside_units)) {
					give_unit_to(n, new_owner);
				}
			}
			if (u_grounded_building(u)) {
				if (u->building.addon) give_unit_to(u->building.addon, new_owner);
				if (unit_is_building_addon(u)) give_unit_to(u->current_build_unit, new_owner);
				if (unit_is_nydus(u) && u->building.nydus.exit) give_unit_to(u->building.nydus.exit, new_owner);
			}
			return true;
		}

		void order_CastMindControl(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || target->owner == u->owner) {
				order_done(u);
				return;
			}
			auto* tech = get_tech_type(TechTypes::Mind_Control);
			if (spell_cast_target_movement(u, tech, unit_sight_range(u, true))) {
				if (u_hallucination(target)) kill_unit(target);
				else {
					create_sized_image(target, ImageTypes::IMAGEID_Mind_Control_Hit_Small);
					trigger_give_unit_to(target, u->owner);
					if (unit_is(target, UnitTypes::Protoss_Dark_Archon)) target->energy = 0_fp8;
					order_done(target);
				}
				u->energy -= fp8::integer(tech->energy_cost);
				u->shield_points = 0_fp8;
				order_done(u);
				//play_sound(1062, target);
			}
		}

		void order_Reaver(unit_t* u) {
			int range = 32 * unit_target_acquisition_range(u);
			if (carrier_reaver_attack(u, range, range * 2)) {
				set_next_target_waypoint(u, u->order_target.pos);
				if (direction_index(u->heading) - direction_index(xy_direction(u->next_target_waypoint - u->sprite->position)) <= 1) {
					if (!u_cannot_attack(u) && u->reaver.outside_count == 0) {
						unit_t* fighter = release_fighter(u);
						if (fighter) {
							set_unit_order(fighter, fighter->unit_type->attack_unit, u->order_target.unit);
							u->main_order_timer = 60;
						}
					}
				}
				else {
					u->order_process_timer = 0;
				}
			}
		}

		void order_ReaverAttack(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target) {
				order_done(u);
				return;
			}
			if (!unit_can_attack_target(u, target)) {
				set_unit_order(u, get_order_type(Orders::Move), u->order_target.pos);
				return;
			}
			bool ready_to_attack = u_ready_to_attack(u);
			bool flag_8 = u_status_flag(u, unit_t::status_flag_8);
			queue_order_front(u, get_order_type(Orders::ReaverFight), target);
			activate_next_order(u);
			u_set_status_flag(u, unit_t::status_flag_ready_to_attack, ready_to_attack);
			u_set_status_flag(u, unit_t::status_flag_8, flag_8);
		}

		int default_remove_timer(const unit_t* u) const {
			if (u_hallucination(u)) return 1350;
			if (unit_is(u, UnitTypes::Zerg_Broodling)) return 1800;
			return 0;
		}

		void set_remove_timer(unit_t* u, int timer) {
			if (u->remove_timer == 0 || timer < u->remove_timer) u->remove_timer = timer;
		}

		void set_remove_timer(unit_t* u) {
			set_remove_timer(u, default_remove_timer(u));
		}

		void order_ScarabAttack(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (u->order_state == 0) {
				set_remove_timer(u, 90);
				u_set_status_flag(u, unit_t::status_flag_no_collide);
				u->main_order_timer = 7;
				if (target) move_to_target(u, target);
				else {
					set_unit_move_target(u, u->order_target.pos);
					set_next_target_waypoint(u, u->order_target.pos);
				}
				u->order_state = 2;
			}
			else if (u->order_state == 2 || u->order_state == 3) {
				if (u->order_state == 2) {
					if (u->main_order_timer == 0) {
						u_unset_status_flag(u, unit_t::status_flag_no_collide);
						u->order_state = 3;
					}
				}
				bool is_at_target;
				if (target) {
					if (unit_target_in_range(u, target, 256) && u_movement_flag(target, 2)) crappy_move_to_target(u, target);
					else try_follow_unit(u, target);
					const weapon_type_t* w = u->unit_type->ground_weapon;
					is_at_target = unit_target_in_range(u, target, w->inner_splash_radius / 2);
				}
				else {
					is_at_target = unit_is_at_move_target(u);
				}
				if (is_at_target) {
					u->order_target.pos = u->sprite->position;
					sprite_run_anim(u->sprite, iscript_anims::SpecialState1);
					u->order_state = 6;
				}
			}
			else if (u->order_state == 6) {
				if (u->order_signal & 1) {
					u_set_status_flag(u, unit_t::status_flag_lifetime_expired);
					kill_unit(u);
				}
			}
		}

		void order_ReaverStop(unit_t* u) {
			stop_unit(u);
			set_next_target_waypoint(u, u->move_target.pos);
			for (unit_t* n : ptr(u->reaver.outside_units)) {
				set_unit_order(n, get_order_type(Orders::SelfDestructing));
			}
			set_unit_order(u, get_order_type(Orders::Reaver), u->order_target.unit);
		}

		void order_RechargeShieldsUnit(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || target->energy == 0_fp8 || unit_is_disabled(target)) {
				order_done(u);
				return;
			}
			if (u->order_state == 0) {
				move_to_target_reset(u, target);
				u->order_state = 1;
			}
			else if (u->order_state == 1) {
				if (unit_is_at_move_target(u)) {
					if (u_immovable(u)) {
						order_done(u);
						return;
					}
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					u->order_state = 2;
				}
				else if (unit_target_in_range(u, target, 128)) {
					stop_unit(u);
					set_next_target_waypoint(u, u->move_target.pos);
					u->order_state = 2;
				}
			}
			if (u->order_state == 2) {
				set_secondary_order(target, get_order_type(Orders::ShieldBattery));
				// TODO
				//create_sized_image(u, ImageTypes::IMAGEID_Recharge_Shields_Small, false);
				queue_order_front(u, get_order_type(Orders::RechargeShieldsUnitRemoveOverlay), {});
				u->order_state = 3;
			}
			if (u->order_state == 3) {
				if (!target->order_target.unit) target->order_target.unit = u;

				fp8 shield_recharge = fp8::integer(u->unit_type->shield_points) - u->shield_points;
				if (shield_recharge > fp8::integer(5)) shield_recharge = fp8::integer(5);
				fp8 energy_cost = shield_recharge / 2;
				if (energy_cost > target->energy) {
					energy_cost = target->energy;
					shield_recharge = energy_cost * 2;
				}
				set_unit_shield_points(u, u->shield_points + shield_recharge);
				target->energy -= energy_cost;

				if (u->shield_points >= fp8::integer(u->unit_type->shield_points) || target->energy == 0_fp8) {
					if (target->order_target.unit == u) target->order_target.unit = nullptr;
					order_done(u);
				}
			}
		}

		void order_RechargeShieldsUnitRemoveOverlay(unit_t* u) {
			destroy_image_from_to(u, ImageTypes::IMAGEID_Recharge_Shields_Small, ImageTypes::IMAGEID_Recharge_Shields_Large);
			if (u->order_queue.empty()) set_queued_order(u, false, u->unit_type->return_to_idle, {});
			u_unset_status_flag(u, unit_t::status_flag_order_not_interruptible);
			order_done(u);
		}

		void order_RechargeShieldsBattery(unit_t* u) {
			unit_t* target = u->order_target.unit;
			set_secondary_order(u, get_order_type(Orders::ShieldBattery));
			if (target && unit_can_use_shield_battery(target, u)) {
				set_unit_order(target, get_order_type(Orders::Follow), u);
			}
			else {
				for (unit_t* n : find_units_noexpand(square_at(u->order_target.pos, 128))) {
					if (unit_can_use_shield_battery(n, u)) set_unit_order(n, get_order_type(Orders::Follow), u);
				}
			}
			order_done(u);
		}

		void order_Feedback(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (!target || !ut_has_energy(target) || u_hallucination(target)) {
				order_done(u);
				return;
			}
			auto* tech = get_tech_type(TechTypes::Feedback);
			if (spell_cast_target_movement(u, tech, unit_sight_range(u, true))) {
				if (target->energy != 0_fp8) {
					weapon_deal_damage(get_weapon_type(WeaponTypes::Feedback), target->energy, 1, target, 1_dir, u, u->owner);
					target->energy = 0_fp8;
					u->energy -= fp8::integer(tech->energy_cost);
					//play_sound(1061, target);
					if (unit_dying(target)) {
						SpriteTypes sprite_id = (SpriteTypes)((int)SpriteTypes::SPRITEID_Feedback_Hit_Small + unit_sprite_size(target));
						thingy_t* t = create_thingy(get_sprite_type(sprite_id), u->sprite->position, 0);
						if (t) {
							t->sprite->elevation_level = u->sprite->elevation_level + 1;
							if (!us_hidden(t)) set_sprite_visibility(t->sprite, tile_visibility(t->sprite->position));
						}
					}
					else {
						create_sized_image(u, ImageTypes::IMAGEID_Feedback_Small);
					}
				}
				order_done(u);
			}
		}

		void kill_interceptors(unit_t* u) {
			if (!unit_is_carrier(u)) return;
			for (auto i = u->carrier.inside_units.begin(); i != u->carrier.inside_units.end();) {
				unit_t* n = &*i++;
				kill_unit(n);
			}
			for (auto i = u->carrier.outside_units.begin(); i != u->carrier.outside_units.end();) {
				unit_t* n = &*i++;
				n->fighter.parent = nullptr;
				set_remove_timer(n, lcg_rand(39, 15, 45));
				u->carrier.outside_units.remove(*n);
				--u->carrier.outside_count;
				n->fighter.fighter_link = { nullptr, nullptr };
			}
		}

		void make_unit_hallucination(unit_t* u) {
			u_set_status_flag(u, unit_t::status_flag_hallucination);
			u_set_status_flag(u, unit_t::status_flag_completed);
			if (!ut_turret(u)) {
				set_remove_timer(u);
				set_secondary_order(u, get_order_type(Orders::Hallucination2));
				if (u->subunit) {
					u_set_status_flag(u->subunit, unit_t::status_flag_hallucination);
				}
				if (unit_is_carrier(u)) {
					kill_interceptors(u);
				}
				else if (unit_is_reaver(u)) {
					for (unit_t* n : ptr(u->reaver.inside_units)) {
						make_unit_hallucination(n);
					}
				}
			}
		}

		unit_t* create_hallucination(unit_t* source_unit, int owner) {
			unit_t* u = create_unit(source_unit->unit_type, source_unit->sprite->position, owner);
			if (!u) {
				return nullptr;
			}
			u->hp = u->unit_type->hitpoints;
			make_unit_hallucination(u);
			set_unit_order(u, u->unit_type->human_ai_idle);
			if (unit_is_reaver(source_unit) && unit_is_reaver(u)) {
				for (unit_t* source_n : ptr(source_unit->reaver.inside_units)) {
					unit_t* n = create_hallucination(source_n, owner);
					if (n) {
						hide_unit(n);
						if (unit_is_fighter(n)) {
							n->fighter.parent = u;
							n->fighter.is_outside = false;
							u->reaver.inside_units.push_front(*n);
							++u->reaver.inside_count;
						}
					}
				}
				for (unit_t* source_n : ptr(source_unit->reaver.outside_units)) {
					unit_t* n = create_hallucination(source_n, owner);
					if (n) {
						hide_unit(n);
						if (unit_is_fighter(n)) {
							n->fighter.parent = u;
							n->fighter.is_outside = false;
							u->reaver.inside_units.push_front(*n);
							++u->reaver.inside_count;
						}
					}
				}
			}
			return u;
		}

		void order_CastHallucination(unit_t* u) {
			auto* tech = get_tech_type(TechTypes::Hallucination);
			if (spell_cast_target_movement(u, tech, unit_sight_range(u, true))) {
				unit_t* target = u->order_target.unit;
				for (int i = 0; i != 2; ++i) {
					unit_t* n = create_hallucination(target, u->owner);
					if (!n) break;
					auto r = find_unit_placement(n, n->sprite->position, false);
					if (!r.first) {
						destroy_unit(n);
						break;
					}
					move_unit(n, r.second);
					if (u_can_turn(n)) {
						size_t index = lcg_rand(32, 0, 32);
						// TODO: Set sprite/image heading/direction
						set_unit_heading(n, direction_from_index(8 * index));
					}
					show_unit(n);
				}
				u->energy -= fp8::integer(tech->energy_cost);
				//play_sound(618, u->order_target.unit);
				// TODO
				//create_image(get_image_type(ImageTypes::IMAGEID_Hallucination_Hit), (target->subunit ? target->subunit : target)->sprite, {}, image_order_top);
				order_done(u);
			}
		}

		void order_SelfDestructing(unit_t* u) {
			kill_unit(u);
		}

		void execute_main_order(unit_t* u) {
			switch (u->order_type->id) {
			case Orders::Die:
				order_Die(u);
				return;
			case Orders::NukeTrack:
				order_NukeTrack(u);
				return;
			case Orders::WarpIn:
				return;
			default:
				break;
			}

			if (unit_is_disabled(u) || (!u_can_move(u) && u_cannot_attack(u))) {
				if (u->main_order_timer == 0) u->main_order_timer = 15;
				if (unit_is_disabled(u)) return;
			}

			switch (u->order_type->id) {
			case Orders::TurretGuard:
				order_TurretGuard(u);
				break;
			case Orders::TurretAttack:
				order_TurretAttack(u);
				break;
			case Orders::DroneBuild:
				order_DroneBuild(u);
				break;
			case Orders::PlaceBuilding:
				order_PlaceBuilding(u);
				break;
			case Orders::PlaceProtossBuilding:
				order_PlaceProtossBuilding(u);
				break;
			case Orders::ConstructingBuilding:
				order_ConstructingBuilding(u);
				break;
			case Orders::Repair:
				order_Repair(u);
				break;
			case Orders::ZergBirth:
				order_ZergBirth(u);
				break;
			case Orders::ZergUnitMorph:
				order_ZergUnitMorph(u);
				break;
			case Orders::IncompleteBuilding:
				order_IncompleteBuilding(u);
				break;
			case Orders::IncompleteMorphing:
				order_IncompleteMorphing(u);
				break;
			case Orders::ScarabAttack:
				order_ScarabAttack(u);
				break;
			case Orders::RechargeShieldsUnit:
				order_RechargeShieldsUnit(u);
				break;
			case Orders::BuildingLand:
				order_BuildingLand(u);
				break;
			case Orders::BuildingLiftoff:
				order_BuildingLiftoff(u);
				break;
			case Orders::ResearchTech:
				order_ResearchTech(u);
				break;
			case Orders::Upgrade:
				order_Upgrade(u);
				break;
			case Orders::GatheringInterrupted:
				order_GatheringInterrupted(u);
				break;
			case Orders::GatherWaitInterrupted:
				order_GatherWaitInterrupted(u);
				break;
			case Orders::RechargeShieldsUnitRemoveOverlay:
				order_RechargeShieldsUnitRemoveOverlay(u);
				break;
			case Orders::Sieging:
				order_Sieging(u);
				break;
			case Orders::Unsieging:
				order_Unsieging(u);
				break;
			case Orders::ArchonWarp:
				order_ArchonWarp(u);
				break;
			case Orders::CompletingArchonSummon:
				order_CompletingArchonSummon(u);
				break;
			case Orders::NukeTrain:
				order_NukeTrain(u);
				break;
			case Orders::InitializeArbiter:
				order_InitializeArbiter(u);
				break;
			case Orders::ResetCollision:
				order_ResetCollision(u);
				break;
			case Orders::ResetHarvestCollision:
				order_ResetHarvestCollision(u);
				break;
			case Orders::CTFCOP2:
				break;
			case Orders::SelfDestructing:
				order_SelfDestructing(u);
				break;
			case Orders::Critter:
				order_Critter(u);
				break;
			case Orders::MedicHeal:
				order_MedicHeal(u);
				break;
			case Orders::HealMove:
				order_HealMove(u);
				break;
			case Orders::MedicHoldPosition:
				order_MedicHoldPosition(u);
				break;
			case Orders::MedicHealToIdle:
				order_MedicHealToIdle(u);
				break;
			case Orders::DarkArchonMeld:
				order_DarkArchonMeld(u);
				break;
			default:
				break;
			}
			if (u->order_process_timer) {
				--u->order_process_timer;
				return;
			}
			u->order_process_timer = 8;
			switch (u->order_type->id) {
			case Orders::Stop:
				order_Stop(u);
				break;
			case Orders::Guard:
				order_Guard(u);
				break;
			case Orders::PlayerGuard:
				order_PlayerGuard(u);
				break;
			case Orders::BunkerGuard:
				break;
			case Orders::Move:
				order_Move(u);
				break;
			case Orders::ReaverStop:
				order_ReaverStop(u);
				break;
			case Orders::MoveToAttack:
				order_MoveToTargetOrder(u);
				break;
			case Orders::AttackUnit:
				order_AttackUnit(u);
				break;
			case Orders::AttackFixedRange:
				order_AttackFixedRange(u);
				break;
			case Orders::Hover:
				break;
			case Orders::AttackMove:
				order_AttackMove(u);
				break;
			case Orders::InfestedCommandCenter:
				order_InfestedCommandCenter(u);
				break;
			case Orders::TowerGuard:
				order_TowerGuard(u);
				break;
			case Orders::TowerAttack:
				order_TowerAttack(u);
				break;
			case Orders::SpiderMine:
				order_SpiderMine(u);
				break;
			case Orders::StayInRange:
				order_StayInRange(u);
				break;
			case Orders::Nothing:
				order_Nothing(u);
				break;
			case Orders::DroneStartBuild:
				order_DroneStartBuild(u);
				break;
			case Orders::CastInfestation:
				order_CastInfestation(u);
				break;
			case Orders::MoveToInfest:
				order_MoveToTargetOrder(u);
				break;
			case Orders::InfestingCommandCenter:
				order_InfestingCommandCenter(u);
				break;
			case Orders::MoveToRepair:
				order_MoveToTargetOrder(u);
				break;
			case Orders::PlaceAddon:
				order_PlaceAddon(u);
				break;
			case Orders::ZergBuildingMorph:
				order_ZergBuildingMorph(u);
				break;
			case Orders::BuildNydusExit:
				order_BuildNydusExit(u);
				break;
			case Orders::EnterNydusCanal:
				order_EnterNydusCanal(u);
				break;
			case Orders::Follow:
				order_Follow(u);
				break;
			case Orders::Carrier:
				order_Carrier(u);
				break;
			case Orders::ReaverCarrierMove:
				order_Move(u);
				break;
			case Orders::CarrierStop:
				order_CarrierStop(u);
				break;
			case Orders::CarrierAttack:
				order_CarrierAttack(u);
				break;
			case Orders::CarrierMoveToAttack:
				order_MoveToTargetOrder(u);
				break;
			case Orders::CarrierIgnore2:
				break;
			case Orders::CarrierFight:
				order_Carrier(u);
				break;
			case Orders::CarrierHoldPosition:
				order_Carrier(u);
				break;
			case Orders::Reaver:
				order_Reaver(u);
				break;
			case Orders::ReaverAttack:
				order_ReaverAttack(u);
				break;
			case Orders::ReaverMoveToAttack:
				order_MoveToTargetOrder(u);
				break;
			case Orders::ReaverFight:
				order_Reaver(u);
				break;
			case Orders::ReaverHoldPosition:
				order_Reaver(u);
				break;
			case Orders::InterceptorAttack:
				order_InterceptorAttack(u);
				break;
			case Orders::RechargeShieldsBattery:
				order_RechargeShieldsBattery(u);
				break;
			case Orders::InterceptorReturn:
				order_InterceptorReturn(u);
				break;
			case Orders::DroneLand:
				order_DroneLand(u);
				break;
			case Orders::DroneLiftOff:
				break;
			case Orders::LiftingOff:
				order_LiftingOff(u);
				break;
			case Orders::Larva:
				order_Larva(u);
				break;
			case Orders::Harvest1:
				order_MoveToGas(u);
				break;
			case Orders::Harvest2:
				order_MoveToTargetOrder(u);
				break;
			case Orders::MoveToGas:
				order_MoveToGas(u);
				break;
			case Orders::WaitForGas:
				order_WaitForGas(u);
				break;
			case Orders::HarvestGas:
				order_HarvestGas(u);
				break;
			case Orders::ReturnGas:
				order_ReturnGas(u);
				break;
			case Orders::MoveToMinerals:
				order_MoveToMinerals(u);
				break;
			case Orders::WaitForMinerals:
				order_WaitForMinerals(u);
				break;
			case Orders::MiningMinerals:
				order_MiningMinerals(u);
				break;
			case Orders::ReturnMinerals:
				order_ReturnMinerals(u);
				break;
			case Orders::EnterTransport:
				order_EnterTransport(u);
				break;
			case Orders::PickupIdle:
				order_PickupIdle(u);
				break;
			case Orders::PickupTransport:
				order_PickupTransport(u);
				break;
			case Orders::PickupBunker:
				order_PickupBunker(u);
				break;
			case Orders::Pickup4:
				break;
			case Orders::WatchTarget:
				order_WatchTarget(u);
				break;
			case Orders::InitCreepGrowth:
				order_InitCreepGrowth(u);
				break;
			case Orders::HoldPosition:
				order_HoldPosition(u);
				break;
			case Orders::QueenHoldPosition:
				order_QueenHoldPosition(u);
				break;
			case Orders::Unload:
				order_Unload(u);
				break;
			case Orders::MoveUnload:
				order_MoveUnload(u);
				break;
			case Orders::FireYamatoGun:
				order_Spell(u);
				break;
			case Orders::MoveToFireYamatoGun:
				order_MoveToTargetOrder(u);
				break;
			case Orders::CastLockdown:
				order_Spell(u);
				break;
			case Orders::Burrowing:
				order_Burrowing(u);
				break;
			case Orders::Burrowed:
				order_Burrowed(u);
				break;
			case Orders::Unburrowing:
				order_Unburrowing(u);
				break;
			case Orders::CastDarkSwarm:
				order_Spell(u);
				break;
			case Orders::CastParasite:
				order_Spell(u);
				break;
			case Orders::CastSpawnBroodlings:
				order_Spell(u);
				break;
			case Orders::CastEMPShockwave:
				order_Spell(u);
				break;
			case Orders::NukeLaunch:
				order_NukeLaunch(u);
				break;
			case Orders::NukePaint:
				order_NukePaint(u);
				break;
			case Orders::NukeUnit:
				order_NukeUnit(u);
				break;
			case Orders::CastNuclearStrike:
				order_CastNuclearStrike(u);
				break;
			case Orders::PlaceMine:
				order_PlaceMine(u);
				break;
			case Orders::RightClickAction:
				order_RightClickAction(u);
				break;
			case Orders::SuicideUnit:
				order_SuicideUnit(u);
				break;
			case Orders::SuicideLocation:
				order_SuicideLocation(u);
				break;
			case Orders::SuicideHoldPosition:
				order_SuicideHoldPosition(u);
				break;
			case Orders::CastRecall:
				order_CastRecall(u);
				break;
			case Orders::Teleport:
				break;
			case Orders::CastScannerSweep:
				order_CastScannerSweep(u);
				break;
			case Orders::Scanner:
				order_Scanner(u);
				break;
			case Orders::CastDefensiveMatrix:
				order_CastDefensiveMatrix(u);
				break;
			case Orders::CastPsionicStorm:
				order_Spell(u);
				break;
			case Orders::CastIrradiate:
				order_Spell(u);
				break;
			case Orders::CastPlague:
				order_Spell(u);
				break;
			case Orders::CastConsume:
				order_Spell(u);
				break;
			case Orders::CastEnsnare:
				order_Spell(u);
				break;
			case Orders::CastStasisField:
				order_Spell(u);
				break;
			case Orders::CastHallucination:
				order_CastHallucination(u);
				break;
			case Orders::Patrol:
				order_Patrol(u);
				break;
			case Orders::CTFCOPInit:
				break;
			case Orders::CTFCOP2:
				break;
			case Orders::ComputerAI:
				break;
			case Orders::AtkMoveEP:
				break;
			case Orders::HarassMove:
				break;
			case Orders::AIPatrol:
				break;
			case Orders::GuardPost:
				break;
			case Orders::ComputerReturn:
				break;
			case Orders::HiddenGun:
				break;
			case Orders::OpenDoor:
				break;
			case Orders::CloseDoor:
				break;
			case Orders::HideTrap:
				break;
			case Orders::RevealTrap:
				break;
			case Orders::EnableDoodad:
				break;
			case Orders::WarpIn:
				break;
			case Orders::MedicIdle:
				order_MedicIdle(u);
				break;
			case Orders::CastRestoration:
				order_Spell(u);
				break;
			case Orders::CastDisruptionWeb:
				order_Spell(u);
				break;
			case Orders::CastMindControl:
				order_CastMindControl(u);
				break;
			case Orders::CastFeedback:
				order_Feedback(u);
				break;
			case Orders::CastOpticalFlare:
				order_Spell(u);
				break;
			case Orders::CastMaelstrom:
				order_Spell(u);
				break;
			default:
				break;
			}
		}

		void secondary_order_Train(unit_t* u) {
			if (unit_is_disabled(u)) return;
			if (unit_race(u) == race_t::zerg && !unit_is(u, UnitTypes::Zerg_Infested_Command_Center)) return;
			if (u->secondary_order_state == 0 || u->secondary_order_state == 1) {
				if (u->build_queue.empty()) {
					set_secondary_order(u, get_order_type(Orders::Nothing));
					sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
				}
				else {
					unit_t* build_unit = nullptr;
					const unit_type_t* build_unit_type = u->build_queue.front();
					if (u_grounded_building(u) || unit_is_carrier(u) || unit_is_reaver(u)) {
						if (has_available_supply_for(u->owner, build_unit_type)) {
							build_unit = create_unit(build_unit_type, u->sprite->position, u->owner);
						}
					}
					u->current_build_unit = build_unit;
					if (build_unit) {
						u->secondary_order_state = 2;
						sprite_run_anim(u->sprite, iscript_anims::IsWorking);
					}
					else {
						u->secondary_order_state = 1;
					}
				}
			}
			else if (u->secondary_order_state == 2) {
				unit_t* build_unit = u->current_build_unit;
				if (build_unit) {
					if (resume_building_unit(build_unit, true)) {
						if (u_completed(build_unit)) {
							if (unit_is(build_unit, UnitTypes::Terran_Nuclear_Missile)) hide_unit(build_unit);
							
							if (!u->build_queue.empty()) u->build_queue.erase(u->build_queue.begin());
							u->current_build_unit = nullptr;
							u->secondary_order_state = 0;
						}
					}
					else {
						if (!u->build_queue.empty()) {
							if (u->current_build_unit) cancel_building_unit(u->current_build_unit);
							else if (!ut_building(u->build_queue.front())) refund_unit_costs(u->owner, u->build_queue.front());
							u->build_queue.erase(u->build_queue.begin());
						}
						u->current_build_unit = nullptr;
						u->secondary_order_state = 0;
					}
				}
				else u->secondary_order_state = 0;
			}
		}

		void secondary_order_BuildAddon(unit_t* u) {
			if (unit_is_disabled(u)) return;
			unit_t* addon = u->current_build_unit;
			if (!addon) {
				u->building.addon_build_type = nullptr;
				set_secondary_order(u, get_order_type(Orders::Nothing));
				return;
			}
			if (!u_grounded_building(u) && !u_completed(addon)) {
				cancel_building_unit(addon);
				u->building.addon_build_type = nullptr;
				set_secondary_order(u, get_order_type(Orders::Nothing));
				return;
			}
			resume_building_unit(addon, false);
			if (u_completed(addon)) {
				// callback for sound
				connect_addon(u, addon);
				u->building.addon_build_type = nullptr;
				set_secondary_order(u, get_order_type(Orders::Nothing));
			}
		}

		void secondary_order_Cloak(unit_t* u) {
			set_unit_cloaked(u);
		}

		void secondary_order_Decloak(unit_t* u) {
			set_secondary_order(u, get_order_type(Orders::Nothing));
		}

		xy get_spawn_larva_position(unit_t* u) {
			int best_score = 101;
			xy best_pos(-1, -1);
			auto test = [&](size_t index, xy pos, xy neighbor_offset) {
				int val = u->building.hatchery.larva_spawn_side_values[index];
				if (val >= best_score) return false;
				if (~st.tiles[tile_index(pos)].flags & tile_t::flag_has_creep) return false;
				auto op = pos + neighbor_offset;
				auto flags = st.tiles[tile_index(op)].flags;
				if (flags & tile_t::flag_occupied) return false;
				if ((flags & (tile_t::flag_walkable | tile_t::flag_has_creep)) == 0) return false;
				best_score = val;
				best_pos = pos;
				return true;
			};
			auto bb = unit_sprite_inner_bounding_box(u);
			test(3, { u->sprite->position.x, bb.to.y + 10 }, { 0, 22 });
			test(0, { bb.from.x - 10, u->sprite->position.y }, { -22, 0 });
			test(2, { bb.to.x + 10, u->sprite->position.y }, { 22, 0 });
			test(1, { u->sprite->position.x, bb.from.y - 10 }, { 0, -22 });
			if (best_pos != xy(-1, -1)) return best_pos;
			int w = (u->unit_type->dimensions.from.x + u->unit_type->dimensions.to.x + 1) / 2;
			int h = (u->unit_type->dimensions.from.y + u->unit_type->dimensions.to.y + 1) / 2;
			best_score = 0x10000;
			if (!test(3, { u->sprite->position.x - w, bb.to.y + 10 }, { 0, 22 }) && !test(3, { u->sprite->position.x + w, bb.to.y + 10 }, { 0, 22 })) {
				best_score = 101;
			}
			test(0, { bb.from.x - 10, u->sprite->position.y - h }, { -22, 0 }) || test(0, { bb.from.x - 10, u->sprite->position.y + h }, { -22, 0 });
			test(2, { bb.to.x + 10, u->sprite->position.y - h }, { 22, 0 }) || test(2, { bb.to.x + 10, u->sprite->position.y + h }, { 22, 0 });
			test(1, { u->sprite->position.x - w, bb.from.y - 10 }, { 0, -22 }) || test(1, { u->sprite->position.x + w, bb.from.y - 10 }, { 0, -22 });
			return best_pos;
		}

		unit_t* spawn_larva(unit_t* u) {
			xy pos = get_spawn_larva_position(u);
			if (pos == xy(-1, -1)) return nullptr;
			unit_t* larva = create_unit(get_unit_type(UnitTypes::Zerg_Larva), pos, u->owner);
			if (larva) {
				finish_building_unit(larva);
				complete_unit(larva);
				larva->connected_unit = u;
				if (larva->sprite->position.x < u->sprite->position.x - u->unit_type->dimensions.from.x) {
					larva->order_state = 0;
				}
				else if (larva->sprite->position.y < u->sprite->position.y - u->unit_type->dimensions.from.y) {
					larva->order_state = 1;
				}
				else if (larva->sprite->position.x > u->sprite->position.x + u->unit_type->dimensions.to.x) {
					larva->order_state = 2;
				}
				else {
					larva->order_state = 3;
				}
			}
			return larva;
		}

		void secondary_order_SpawningLarva(unit_t* u) {
			if (u->order_process_timer) return;
			if (u->owner == 11) return;
			int larva_count = 0;
			for (unit_t* n : find_units_noexpand(square_at(u->sprite->position, 32 * 8))) {
				if (!unit_is(n, UnitTypes::Zerg_Larva)) continue;
				if (n->connected_unit != u) continue;
				if (us_hidden(n)) continue;
				++larva_count;
				if (larva_count >= 3) return;
			}
			if (u->building.larva_timer) {
				--u->building.larva_timer;
				return;
			}
			if (spawn_larva(u)) u->building.larva_timer = 37;
			else u->building.larva_timer = 3;
		}

		bool spread_creep(unit_type_autocast unit_type, xy pos, bool* out_any_tiles_occupied = nullptr) {
			// TODO: Rewrite for Factorio
			return false;
		}

		void secondary_order_SpreadCreep(unit_t* u) {
			if (unit_is_hatchery(u)) secondary_order_SpawningLarva(u);
			if (u->building.creep_timer) {
				--u->building.creep_timer;
				return;
			}
			u->building.creep_timer = 15;
			bool any_tiles_occupied = false;
			if (!spread_creep(get_unit_type(UnitTypes::Zerg_Hive), u->sprite->position, &any_tiles_occupied) && !any_tiles_occupied) {
				if (unit_is_hatchery(u)) set_secondary_order(u, get_order_type(Orders::SpawningLarva));
				else set_secondary_order(u, get_order_type(Orders::Nothing));
			}
		}

		void secondary_order_CloakNearbyUnits(unit_t* u) {
			auto* w = unit_air_weapon(u);
			int range = weapon_max_range(u, w);
			auto area = square_at(u->sprite->position, range);
			for (unit_t* target : find_units_noexpand(area)) {
				if (target->owner != u->owner) continue;
				if (ut_building(target)) continue;
				if (unit_is_arbiter(target)) continue;
				if (u_hallucination(target)) continue;
				if (ut_powerup(target)) continue;
				if (unit_is(target, UnitTypes::Terran_Nuclear_Missile)) continue;
				if (target->order_type->id == Orders::WarpIn) continue;
				if (!unit_target_in_range(u, target, range)) continue;
				set_unit_cloaked(target);
				if (!u_passively_cloaked(target)) u_set_status_flag(target, unit_t::status_flag_passively_cloaked);
			}
		}

		void secondary_order_TrainFighter(unit_t* u) {
			if (!unit_is_carrier(u) && !unit_is_reaver(u)) return;
			if (u->secondary_order_state == 0 || u->secondary_order_state == 1) {
				if (u->build_queue.empty()) {
					u->secondary_order_state = 3;
					u->current_build_unit = nullptr;
				}
				else {
					unit_t* build_unit = nullptr;
					const unit_type_t* build_unit_type = u->build_queue.front();
					if (u_grounded_building(u) || unit_is_carrier(u) || unit_is_reaver(u)) {
						if (has_available_supply_for(u->owner, build_unit_type)) {
							build_unit = create_unit(build_unit_type, u->sprite->position, u->owner);
						}
					}
					u->current_build_unit = build_unit;
					if (build_unit) {
						if (unit_is_fighter(build_unit)) build_unit->fighter.parent = u;
						u->secondary_order_state = 2;
					}
					else u->secondary_order_state = 1;
				}
			}
			else if (u->secondary_order_state == 2) {
				unit_t* build_unit = u->current_build_unit;
				if (!build_unit) {
					u->secondary_order_state = 0;
				}
				else {
					resume_building_unit(build_unit, false);
					if (u_completed(build_unit)) {
						hide_unit(build_unit);
						if (unit_is_fighter(build_unit)) {
							if (unit_is_carrier(u)) {
								u->carrier.inside_units.push_front(*build_unit);
								++u->carrier.inside_count;
							}
							else if (unit_is_reaver(u)) {
								u->reaver.inside_units.push_front(*build_unit);
								++u->reaver.inside_count;
							}
							build_unit->fighter.is_outside = false;
						}
						u->build_queue.erase(u->build_queue.begin());
						u->current_build_unit = nullptr;
						u->secondary_order_state = 0;
					}
				}
			}
			else if (u->secondary_order_state == 3) {
				if (unit_is_carrier(u)) {
					for (unit_t* n : ptr(u->carrier.inside_units)) {
						if (n->hp >= n->unit_type->hitpoints) continue;
						set_unit_hp(n, n->hp + 128_fp8);
						break;
					}
				}
				else u->secondary_order_state = 4;
			}
		}

		void secondary_order_ShieldBattery(unit_t* u) {
			unit_t* target = u->order_target.unit;
			if (u->secondary_order_state == 0) {
				if (target) {
					sprite_run_anim(u->sprite, iscript_anims::IsWorking);
					u->secondary_order_state = 1;
				}
			}
			else if (u->secondary_order_state == 1) {
				if (target) {
					if (target->order_type->id != Orders::RechargeShieldsUnit) {
						u->order_target.unit = nullptr;
						u->secondary_order_state = 2;
					}
				}
				else u->secondary_order_state = 2;
			}
			else if (u->secondary_order_state == 2) {
				if (target) u->secondary_order_state = 1;
				else {
					sprite_run_anim(u->sprite, iscript_anims::WorkingToIdle);
					u->secondary_order_state = 0;
				}
			}
		}

		void execute_secondary_order(unit_t* u) {
			if (u->secondary_order_type->id == Orders::Hallucination2) {
				if (u->defensive_matrix_hp != 0_fp8 || u->stim_timer || u->ensnare_timer || u->lockdown_timer || u->irradiate_timer || u->stasis_timer || u->parasite_flags || u->storm_timer || u->plague_timer || u->blinded_by || u->maelstrom_timer) {
					kill_unit(u);
				}
				return;
			}
			if (unit_is_disabled(u)) return;
			switch (u->secondary_order_type->id) {
			case Orders::BuildAddon:
				secondary_order_BuildAddon(u);
				break;
			case Orders::Train:
				secondary_order_Train(u);
				break;
			case Orders::TrainFighter:
				secondary_order_TrainFighter(u);
				break;
			case Orders::ShieldBattery:
				secondary_order_ShieldBattery(u);
				break;
			case Orders::SpawningLarva:
				secondary_order_SpawningLarva(u);
				break;
			case Orders::SpreadCreep:
				secondary_order_SpreadCreep(u);
				break;
			case Orders::Cloak:
				secondary_order_Cloak(u);
				break;
			case Orders::Decloak:
				secondary_order_Decloak(u);
				break;
			case Orders::CloakNearbyUnits:
				secondary_order_CloakNearbyUnits(u);
				break;
			default:
				break;
			}
		}
		bool iscript_execute_sprite(sprite_t* sprite) {
			// TODO
			return true;
		}
		void update_unit(unit_t* u) {
			update_unit_values(u);

			execute_main_order(u);
			execute_secondary_order(u);

			if (u->subunit && !ut_turret(u)) {
				auto ius = make_thingy_setter(iscript_unit, u->subunit);
				update_unit(u->subunit);
			}
			if (u->sprite) {
				if (!iscript_execute_sprite(u->sprite)) u->sprite = nullptr;
			}
		}


		void turn_turret(unit_t* u, direction_t turn) {
			if (u->order_target.unit) u_unset_status_flag(u, (unit_t::status_flags_t)0x2000000);
			else {
				if (u->heading == u->subunit->heading) u_set_status_flag(u, (unit_t::status_flags_t)0x2000000);
			}
			if (u_status_flag(u, (unit_t::status_flags_t)0x2000000)) set_unit_heading(u, u->subunit->heading);
			else {
				u->next_velocity_direction = (u->next_velocity_direction + turn);
				u->heading = u->next_velocity_direction;
			}
			if (unit_is(u, UnitTypes::Terran_Goliath_Turret) || unit_is(u, UnitTypes::Hero_Alan_Schezar_Turret)) {
				auto diff = u->subunit->heading - u->heading;
				if (diff > 32_dir) {
					u->heading = u->subunit->heading - 32_dir;
				}
				else if (diff < -32_dir) {
					u->heading = u->subunit->heading + 32_dir;
				}
			}
		}

		void update_unit_movement(unit_t* u) {

			auto prev_velocity_direction = u->next_velocity_direction;
			execute_movement(u);

			if (u_completed(u) && u->subunit && !ut_turret(u)) {
				turn_turret(u->subunit, u->next_velocity_direction - prev_velocity_direction);
				u->subunit->exact_position = u->exact_position;
				u->subunit->position = to_xy(u->exact_position);
				move_sprite(u->subunit->sprite, u->subunit->position);
				//set_image_offset(u->subunit->sprite->main_image, get_image_lo_offset(u->sprite->main_image, 2, 0));
				auto ius = make_thingy_setter(iscript_unit, u->subunit);
				if (!u_movement_flag(u, 2)) {
					if (u_status_flag(u->subunit, unit_t::status_flag_turret_walking)) {
						u_unset_status_flag(u->subunit, unit_t::status_flag_turret_walking);
						if (u_can_move(u) && !u_movement_flag(u->subunit, 8)) {
							sprite_run_anim(u->subunit->sprite, iscript_anims::WalkingToIdle);
						}
					}
				}
				else {
					if (!u_status_flag(u->subunit, unit_t::status_flag_turret_walking)) {
						u_set_status_flag(u->subunit, unit_t::status_flag_turret_walking);
						if (u_can_move(u) && !u_movement_flag(u->subunit, 8)) {
							sprite_run_anim(u->subunit->sprite, iscript_anims::Walking);
						}
					}
				}
				update_unit_movement(u->subunit);
			}
		}

		bool unit_can_fire_from_bunker(unit_t* u) {
			return unit_is_marine(u) || unit_is_firebat(u) || unit_is_ghost(u);
		}

		void order_hidden_BunkerGuard(unit_t* u) {
			if (!unit_can_fire_from_bunker(u)) return;
			u_set_status_flag(u, unit_t::status_flag_ready_to_attack);
			if (u->subunit) u_set_status_flag(u->subunit, unit_t::status_flag_ready_to_attack);
			if (try_attack_something(u)) {
				set_next_target_waypoint(u, u->order_target.pos);
			}
			else {
				if (u->main_order_timer == 0) {
					u->main_order_timer = 15;
					u->order_target.unit = find_acquire_random_target(u);
					if (u->order_target.unit) u->order_process_timer = 0;
				}
			}
		}

		void execute_hidden_unit_main_order(unit_t* u) {
			switch (u->order_type->id) {
			case Orders::Die:
				order_Die(u);
				return;
			case Orders::PlayerGuard:
			case Orders::TurretGuard:
			case Orders::TurretAttack:
			case Orders::EnterTransport:
				set_unit_order(u, get_order_type(u_in_bunker(u) ? Orders::BunkerGuard : Orders::Nothing));
				return;
			case Orders::Nothing:
				return;
			case Orders::NothingWait:
				return;
			case Orders::InfestingCommandCenter:
				order_InfestingCommandCenter(u);
				return;
			case Orders::HarvestGas:
				order_HarvestGas(u);
				return;
			case Orders::PowerupIdle:
				return;
			case Orders::NukeLaunch:
				order_NukeLaunch(u);
				return;
			case Orders::ResetCollision:
				order_ResetCollision(u);
				return;
			case Orders::ResetHarvestCollision:
				order_ResetHarvestCollision(u);
				return;
			case Orders::MedicIdle:
				return;
			case Orders::MedicHeal:
				return;
			default:
				break;
			}
			if (u->order_process_timer) {
				--u->order_process_timer;
				return;
			}
			u->order_process_timer = 8;
			switch (u->order_type->id) {
			case Orders::BunkerGuard:
				order_hidden_BunkerGuard(u);
				break;
			case Orders::EnterTransport:
				break;
			case Orders::ComputerAI:
				break;
			default:
				break;
			}
		}

		void execute_hidden_unit_secondary_order(unit_t* u) {
			switch (u->secondary_order_type->id) {
			case Orders::TrainFighter:
				secondary_order_TrainFighter(u);
				break;
			case Orders::Cloak:
				secondary_order_Cloak(u);
				break;
			case Orders::Decloak:
				secondary_order_Decloak(u);
				break;
			default:
				break;
			}
		}

		void update_hidden_unit(unit_t* u) {
			if (u->subunit && !ut_turret(u)) {
				auto ius = make_thingy_setter(iscript_unit, u->subunit);
				update_hidden_unit(u->subunit);
			}

			execute_movement(u);
			update_unit_values(u);

			execute_hidden_unit_main_order(u);
			execute_hidden_unit_secondary_order(u);

			if (u->sprite) {
				if (!iscript_execute_sprite(u->sprite)) u->sprite = nullptr;
			}
		}

		void update_units() {
			--st.order_timer_counter;
			if (!st.order_timer_counter) {
				st.order_timer_counter = 150;
				int v = 0;
				for (unit_t* u : ptr(st.visible_units)) {
					u->order_process_timer = v;
					++v;
					if (v == 8) v = 0;
				}
			}
			--st.secondary_order_timer_counter;
			if (!st.secondary_order_timer_counter) {
				st.secondary_order_timer_counter = 300;
				int v = 0;
				for (unit_t* u : ptr(st.visible_units)) {
					u->secondary_order_timer = v;
					++v;
					if (v == 30) v = 0;
				}
			}

			//update_disruption_web();

			for (unit_t* u : ptr(st.visible_units)) {
				iscript_flingy = u;
				iscript_unit = u;
				update_unit_movement(u);
			}

			for (unit_t* u : ptr(st.visible_units)) {
				update_unit_sprite(u);
				if (u_cloaked(u) || u_requires_detector(u)) {
					if (u->secondary_order_timer) --u->secondary_order_timer;
					else {
						update_unit_detected_flags(u);
						u->secondary_order_timer = 30;
					}
				}
			}

			for (auto i = st.visible_units.begin(); i != st.visible_units.end();) {
				unit_t* u = &*i++;
				iscript_flingy = u;
				iscript_unit = u;
				update_unit(u);
			}

			for (auto i = st.hidden_units.begin(); i != st.hidden_units.end();) {
				unit_t* u = &*i++;
				//if (u_cloaked(u) || u_requires_detector(u)) u->cloak_counter = 0;
				iscript_flingy = u;
				iscript_unit = u;
				update_hidden_unit(u);
			}

			/*
			for (auto i = st.cloaked_units.begin(); i != st.cloaked_units.end();) {
				unit_t* u = &*i++;
				if (u->cloak_counter == 0) {
					st.cloaked_units.remove(*u);
					u->cloaked_unit_link = { nullptr, nullptr };
					u_unset_status_flag(u, unit_t::status_flag_passively_cloaked);
					decloak_unit(u);
				}
				else {
					if (!u_burrowed(u) && u->secondary_order_type->id == Orders::Cloak && u->cloak_counter == 1 && u_passively_cloaked(u)) {
						u_unset_status_flag(u, unit_t::status_flag_passively_cloaked);
					}
					if (!u_requires_detector(u)) cloak_unit(u);
				}
			}*/

			//st.recent_lurker_hit_current_index = (st.recent_lurker_hit_current_index + 1) % st.recent_lurker_hits.size();
			//st.recent_lurker_hits[st.recent_lurker_hit_current_index].clear();

			iscript_flingy = nullptr;
			iscript_unit = nullptr;
		}

	};
}

int main() {}
