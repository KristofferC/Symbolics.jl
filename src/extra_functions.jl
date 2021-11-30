@register Base.binomial(n,k)

@register Base.sign(x)::Int
derivative(::typeof(sign), args::NTuple{1,Any}, ::Val{1}) = 0

@register Base.signbit(x)::Bool
derivative(::typeof(signbit), args::NTuple{1,Any}, ::Val{1}) = 0
derivative(::typeof(abs), args::NTuple{1,Any}, ::Val{1}) = IfElse.ifelse(signbit(args[1]),-one(args[1]),one(args[1]))

function derivative(::typeof(min), args::NTuple{2,Any}, ::Val{1})
    x, y = args
    IfElse.ifelse(x < y, one(x), zero(x))
end
function derivative(::typeof(min), args::NTuple{2,Any}, ::Val{2})
    x, y = args
    IfElse.ifelse(x < y, zero(y), one(y))
end
function derivative(::typeof(max), args::NTuple{2,Any}, ::Val{1})
    x, y = args
    IfElse.ifelse(x > y, one(x), zero(x))
end
function derivative(::typeof(max), args::NTuple{2,Any}, ::Val{2})
    x, y = args
    IfElse.ifelse(x > y, zero(y), one(y))
end

@register Base.ceil(x)
@register Base.floor(x)
@register Base.factorial(x)

function derivative(::Union{typeof(ceil),typeof(floor),typeof(factorial)}, args::NTuple{1,Any}, ::Val{1})
    zero(args[1])
end

@register Base.rand(x)
@register Base.randn(x)

@register Distributions.pdf(dist,x)
@register Distributions.logpdf(dist,x)
@register Distributions.cdf(dist,x)
@register Distributions.logcdf(dist,x)
@register Distributions.quantile(dist,x)

@register Distributions.Uniform(mu,sigma) false
@register Distributions.Normal(mu,sigma) false

@register ∈(x::Real, y::AbstractArray)::Bool
@register ∪(x, y)
@register ∩(x, y)
@register ∨(x, y)
@register ∧(x, y)
@register ⊆(x, y)

LinearAlgebra.norm(x::Num, p::Real) = abs(x)
